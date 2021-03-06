proc demo(alpha=1, verb=false, stuff = @[ "ab", "cd" ], args: seq[string]): int=
  ## demo entry point with varied, meaningless parameters.  A Nim invocation
  ## might be: demo(alpha=2, @[ "hi", "ho" ]) corresponding to the command
  ## invocation "demo --alpha=2 hi ho" (assuming executable gets named demo).
  echo "alpha:", alpha, " verb:", verb, " stuff:", repr(stuff)
  for i, arg in args: echo "positional[", i, "]: ", repr(arg)
  return 42

when isMainModule:
  from strutils import split, `%`, join
  from cligen/argcvt import ArgcvtParams, argKeys, argDf, ERR  # Little helpers

  proc argParse(dst: var seq[string], dfl: seq[string], a: var ArgcvtParams): bool =
    if a.val == nil:
      ERR("Bad value nil for CSV param \"$1\"\n$2" % [ a.key, a.help ])
      return false
    dst = a.val.split(",")
    return true

  proc argHelp(dfl: seq[string]; a: var ArgcvtParams): seq[string] =
    result = @[ a.argKeys, "CSV", a.argDf("\"" & dfl.join(",") & "\"") ]

  import cligen
  dispatch(demo)
