# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "pypdf",
#     "rich",
#     "tyro",
# ]
# ///

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Literal

import tyro
from pypdf import PdfReader, PdfWriter
from rich.console import Console
from rich.panel import Panel
from rich.table import Table

console = Console()


@dataclass
class PdfArgs:
    """Arguments for PDF operations"""

    action: Literal["analyze", "cut"]
    """The action to perform on the PDF file"""

    path: str
    """The file path to a pdf"""

    pages: list[int] | None = None
    """The pages to extract from the pdf"""


def analyze_pdf(pdf_path: str) -> dict:
    """
    Analyze a PDF file and return its properties

    Args:
        pdf_path (str): Path to the PDF file

    Returns:
        dict: Dictionary containing PDF properties
    """
    try:
        # Get file size in MB
        file_size = os.path.getsize(pdf_path) / (1024 * 1024)

        # Open PDF and get number of pages
        reader = PdfReader(pdf_path)
        num_pages = len(reader.pages)

        # Create info dictionary
        pdf_info = {"path": pdf_path, "size": round(file_size, 2), "pages": num_pages}

        # Create a table for nice output
        table = Table(title="PDF Analysis")
        table.add_column("Property", style="cyan")
        table.add_column("Value", style="green")

        table.add_row("File Path", pdf_path)
        table.add_row("File Size", f"{pdf_info['size']} MB")
        table.add_row("Number of Pages", str(pdf_info["pages"]))

        console.print(Panel(table, title="PDF Analysis Results", border_style="blue"))

        return pdf_info

    except Exception as e:
        console.print(f"[red]Error analyzing PDF: {str(e)}[/red]")
        raise


def extract_pages(
    pdf_path: str, pages: list[int], output_suffix: str = "_extracted"
) -> str:
    """
    Create a new PDF with selected pages

    Args:
        pdf_path (str): Path to the source PDF
        pages (list[int]): List of page numbers to extract (1-based indexing)
        output_suffix (str): Suffix to add to the output filename

    Returns:
        str: Path to the created PDF
    """
    try:
        # Create path object
        path = Path(pdf_path)

        # Create output filename
        output_path = path.parent / f"{path.stem}{output_suffix}{path.suffix}"

        with console.status("[bold green]Extracting pages..."):
            reader = PdfReader(pdf_path)
            writer = PdfWriter()
            # Validate page numbers
            max_pages = len(reader.pages)
            valid_pages = [p for p in pages if 1 <= p <= max_pages]

            if not valid_pages:
                raise ValueError("No valid pages specified")

            # Add selected pages to the new PDF
            for page_num in valid_pages:
                # Convert to 0-based index
                writer.add_page(reader.pages[page_num - 1])

            # Save the new PDF
            with open(output_path, "wb") as output_file:
                writer.write(output_file)

        # Show success message with details
        console.print(
            Panel(
                f"""[green]Successfully created new PDF:
         Source: {pdf_path}
         Output: {output_path}
         Extracted pages: {valid_pages}[/green]""",
                title="Extraction Complete",
                border_style="green",
            )
        )

        return str(output_path)
    except Exception as e:
        console.print(f"[red]Error extracting pages: {str(e)}[/red]")
        raise


def analyze(path: str):
    """Analyze a PDF file"""
    analyze_pdf(path)


def extract(path: str, pages: list[int]):
    extract_pages(path, pages)


if __name__ == "__main__":
    # This will only run if the script is executed directly
    # You can add a simple CLI here if needed
    console.print("[bold blue]PDF Utility Script[/bold blue]")
    console.print("Use --help for available commands.")

    args = tyro.cli(PdfArgs)

    if args.action == "analyze":
        analyze(args.path)

    elif args.action == "cut":
        if args.pages is None:
            console.print("[red]Please specify pages to extract.[/red]")
        else:
            extract(args.path, args.pages)
    else:
        console.print("[red]Invalid action. Use 'analyze' or 'cut'.[/red]")
