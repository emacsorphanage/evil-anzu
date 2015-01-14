# evil-anzu

[anzu](https://github.com/syohex/emacs-anzu) for [evil-mode](https://gitorious.org/evil)

evil-anzu is currently under development.

## Screencast

![evil-anzu](image/evil-anzu.gif)

## Configuration

```lisp
(define-key evil-motion-state-map "n" 'evil-anzu-search-next)
(define-key evil-motion-state-map "N" 'evil-anzu-search-previous)
```
