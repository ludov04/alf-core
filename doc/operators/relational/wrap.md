
Relational wraping (tuple-valued attributes)

SYNOPSIS

  #{shell_signature}

DESCRIPTION

This operator wraps attributes in ATTR_LIST as a new, tuple-valued
attribute named AS.

With --allbut, it wraps all attributes not specified in ATTR_LIST instead.

EXAMPLE

  alf wrap suppliers -- city status -- loc_and_status
