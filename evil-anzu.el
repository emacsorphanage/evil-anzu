;;; evil-anzu.el --- anzu for evil-mode

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; Version: 0.01
;; Package-Requires: ((anzu "0.46"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'evil)
(require 'anzu)

(defgroup evil-anzu nil
  "anzu for evil-mode"
  :group 'anzu)

(defvar evil-anzu--displayed nil)

(defconst evil-anzu--search-commands
  '(evil-anzu-search-next evil-anzu-search-previous))

(defun evil-anzu--update ()
  (anzu--cons-mode-line 'search)
  (let ((query (if evil-regexp-search
                   (car-safe regexp-search-ring)
                 (car-safe search-ring))))
    (anzu--update query))
  (setq evil-anzu--displayed t))

(evil-define-motion evil-anzu-search-next (count)
  "Repeat the last search."
  :jump t
  :type exclusive
  (dotimes (var (or count 1))
    (evil-search (if evil-regexp-search
                     (car-safe regexp-search-ring)
                   (car-safe search-ring))
                 isearch-forward evil-regexp-search))
  (evil-anzu--update))

(evil-define-motion evil-anzu-search-previous (count)
  "Repeat the last search in the opposite direction."
  :jump t
  :type exclusive
  (dotimes (var (or count 1))
    (evil-search (if evil-regexp-search
                     (car-safe regexp-search-ring)
                   (car-safe search-ring))
                 (not isearch-forward) evil-regexp-search))
  (evil-anzu--update))

(defun evil-anzu--pre-command-hook ()
  (when (and evil-anzu--displayed (not (memq this-command evil-anzu--search-commands)))
    (anzu--reset-mode-line)
    (setq evil-anzu--displayed nil)))

(defun evil-anzu--reset-mode-line ()
  (when (and anzu-cons-mode-line-p (anzu--mode-line-not-set-p))
    (setq mode-line-format (delete anzu--mode-line-format mode-line-format))))

(define-minor-mode evil-anzu-mode
  "anzu for evil-mode."
  :group      'evil-anzu
  :init-value nil
  :global     nil
  :lighter    anzu-mode-lighter
  (if evil-anzu-mode
      (progn
        (add-hook 'isearch-update-post-hook 'anzu--update-post-hook nil t)
        (add-hook 'isearch-mode-hook 'anzu--cons-mode-line-search nil t)
        (add-hook 'isearch-mode-end-hook 'evil-anzu--reset-mode-line nil t)
        (add-hook 'pre-command-hook 'evil-anzu--pre-command-hook nil t))
    (remove-hook 'isearch-update-post-hook 'anzu--update-post-hook t)
    (remove-hook 'isearch-mode-hook 'anzu--cons-mode-line t)
    (remove-hook 'isearch-mode-end-hook 'anzu--reset-mode-line t)
    (remove-hook 'pre-command-hook 'evil-anzu--pre-command-hook t)
    (anzu--reset-mode-line)))

(defun evil-anzu--turn-on ()
  (unless (minibufferp)
    (evil-anzu-mode +1)))

;;;###autoload
(define-globalized-minor-mode global-evil-anzu-mode evil-anzu-mode evil-anzu--turn-on
  :group 'evil-anzu)

(defadvice evil-search (before reset-anzu-information activate)
  (anzu--reset-status))

(provide 'evil-anzu)

;;; evil-anzu.el ends here
