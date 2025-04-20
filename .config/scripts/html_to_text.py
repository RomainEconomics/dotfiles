# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "httpx",
#     "markdownify",
#     "tyro",
# ]
# ///


"""
Fetches a webpage using httpx and converts its HTML content to Markdown
using markdownify.
"""

import sys
from dataclasses import dataclass

import httpx
import markdownify
import tyro


@dataclass
class Args:
    """Fetch a webpage and convert its HTML to Markdown."""

    url: str
    """The URL of the webpage to fetch."""

    timeout: float = 10.0
    """Request timeout in seconds (default: 10.0)"""


def fetch_and_convert(url: str, timeout: float = 10.0) -> str | None:
    """
    Fetches the HTML content of a URL and converts it to Markdown.

    Args:
        url: The URL to fetch.
        timeout: Request timeout in seconds.

    Returns:
        The Markdown content as a string, or None if an error occurred.
    """
    try:
        with httpx.Client(follow_redirects=True, timeout=timeout) as client:
            response = client.get(url)
            response.raise_for_status()  # Raise HTTPStatusError for 4xx/5xx responses
            html_content = response.text
            markdown_text = markdownify.markdownify(html_content)
            return markdown_text

    except httpx.RequestError as exc:
        print(f"Error during request to {exc.request.url!r}: {exc}", file=sys.stderr)
    except httpx.HTTPStatusError as exc:
        print(
            f"HTTP error {exc.response.status_code} while requesting {exc.request.url!r}",
            file=sys.stderr,
        )
    except Exception as exc:
        print(f"An unexpected error occurred: {exc}", file=sys.stderr)

    return None


def main():
    """Main execution function."""
    args = tyro.cli(Args)

    markdown_output = fetch_and_convert(args.url, args.timeout)

    if markdown_output:
        print(markdown_output)
    else:
        sys.exit(1)  # Indicate failure


if __name__ == "__main__":
    main()
