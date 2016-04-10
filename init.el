;;; init.el --- The first thing GNU Emacs runs

;; Decrease the number of times garbage collection is invoked during startup.
;; This drastically improves `emacs-init-time'.
(setq gc-cons-threshold 100000000);== 100 MB

;; Ignore default regex checks of filenames during startup.
;; This also drastically improves `emacs-init-time'.
(let ((file-name-handler-alist nil))

  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

  ;; Bootstrap `use-package'.
  ;; It will manage all other package installs/configurations.
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile
    (require 'use-package))

  (require 'bind-key)
  (require 'cl)                         ; Needed for certain major modes
  (require 'diminish)

  ;; Tangle and load the rest of the config
  (org-babel-load-file "~/.emacs.d/conf.org"))

;; Revert garbage collection behavior
(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold 1000000)));== 1.0 MB

;;; init.el ends here
