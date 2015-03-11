# evil-anzu [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

[anzu](https://github.com/syohex/emacs-anzu) for [evil-mode](https://gitorious.org/evil)


## Screencast

![evil-anzu](image/evil-anzu.gif)

## Installation

You can install evil-anzu.el from [MELPA](http://melpa.org) with package.el.

## Configuration

You can use `evil-anzu.el` only loading.

```lisp
;; Emacs 24.4 or higher
(with-eval-after-load 'evil
  (require 'evil-anzu))

;; Emacs <= 24.3
(eval-after-load 'evil
  '(progn
     (require 'evil-anzu)))
```

[melpa-link]: http://melpa.org/#/evil-anzu
[melpa-stable-link]: http://stable.melpa.org/#/evil-anzu
[melpa-badge]: http://melpa.org/packages/evil-anzu-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/evil-anzu-badge.svg
