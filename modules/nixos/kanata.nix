# Swedish characters (a-ring/a-umlaut/o-umlaut) on a US layout via a held AltGr layer.
# Ported verbatim from the dotfiles' kanata config.kbd. The NixOS module supplies the
# defcfg block, so only defsrc/deflayer/defalias go in `config`.
{ ... }:

{
  services.kanata = {
    enable = true;
    keyboards.internal = {
      extraDefCfg = "linux-unicode-termination enter";
      config = ''
        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rmet rctl
        )

        (deflayer base
          _    _    _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _              _              @agl _    _
        )

        (defalias
          agl (layer-while-held altgr)
        )

        (deflayer altgr
          _    _    _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _    _    _    _    _    _    _    _    _    (fork (unicode å) (unicode Å) (lshift rshift))    _    _
          _    _    _    _    _    _    _    _    _    _    (fork (unicode ö) (unicode Ö) (lshift rshift))    (fork (unicode ä) (unicode Ä) (lshift rshift))    _
          _    _    _    _    _    _    _    _    _    _    _    _
          _    _    _              _              _    _    _
        )
      '';
    };
  };
}
