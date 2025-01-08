return {
  s('ternary', {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, 'cond'),
    t ' ? ',
    i(2, 'then'),
    t ' : ',
    i(3, 'else'),
  }),
  s('bash', {
    t { '```bash', '' },
    i(1),
    t { '', '```' },
  }),
  s('br', {
    t { '```' },
    i(1, 'language'),
    i(0),
    t { '', '```' },
  }),
}
