(add-hook 'after-init-hook 'global-company-mode)

                                        ;(if (fboundp 'evil-declare-change-repeat)
                                        ;    (mapc #'evil-declare-change-repeat
                                        ;          '(company-complete-common
                                        ;            company-select-next
                                        ;            company-select-previous
                                        ;            company-complete-selection
                                        ;            company-complete-number
                                        ;            )))

(eval-after-load 'company
  '(progn
     ;; @see https://github.com/company-mode/company-mode/issues/348
     (require 'company-statistics)
     (company-statistics-mode)

     (add-to-list 'company-backends 'company-cmake)
     (add-to-list 'company-backends 'company-c-headers)
     ;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))
     ;; (setq company-backends (delete 'company-capf company-backends))

     ;; I don't like the downcase word in company-dabbrev!
     (setq company-dabbrev-downcase nil
           ;; make previous/next selection in the popup cycles
           company-selection-wrap-around t
           ;; Some languages use camel case naming convention,
           ;; so company should be case sensitive.
           company-dabbrev-ignore-case nil
           ;; press M-number to choose candidate
           company-show-numbers t
           company-idle-delay 0.2
           company-clang-insert-arguments nil
           company-require-match nil
           company-etags-ignore-case t)

     ;; @see https://github.com/redguardtoo/emacs.d/commit/2ff305c1ddd7faff6dc9fa0869e39f1e9ed1182d
     (defadvice company-in-string-or-comment (around company-in-string-or-comment-hack activate)
       ;; you can use (ad-get-arg 0) and (ad-set-arg 0) to tweak the arguments
       (if (memq major-mode '(php-mode html-mode web-mode nxml-mode))
           (setq ad-return-value nil)
         ad-do-it))

     ;; press SPACE will accept the highlighted candidate and insert a space
     ;; `M-x describe-variable company-auto-complete-chars` for details
     ;; That's BAD idea.
                                        ;     (setq company-auto-complete nil)

     ;; NOT to load company-mode for certain major modes.
     ;; Ironic that I suggested this feature but I totally forgot it
     ;; until two years later.
     ;; https://github.com/company-mode/company-mode/issues/29
     (setq company-global-modes
           '(not
             eshell-mode comint-mode erc-mode gud-mode rcirc-mode 
             minibuffer-inactive-mode))))


;; {{ setup company-ispell
(defun toggle-company-ispell ()
  (interactive)
  (cond
   ((memq 'company-ispell company-backends)
    (setq company-backends (delete 'company-ispell company-backends))
    (message "company-ispell disabled"))
   (t
    (add-to-list 'company-backends 'company-ispell)
    (message "company-ispell enabled!"))))

(defun company-ispell-setup ()
  ;; @see https://github.com/company-mode/company-mode/issues/50
  (when (boundp 'company-backends)
    (make-local-variable 'company-backends)
    (add-to-list 'company-backends 'company-ispell)
    ;; https://github.com/redguardtoo/emacs.d/issues/473
    (if (and (boundp 'ispell-alternate-dictionary)
             ispell-alternate-dictionary)
        (setq company-ispell-dictionary ispell-alternate-dictionary))))

;; message-mode use company-bbdb.
;; So we should NOT turn on company-ispell
(add-hook 'org-mode-hook 'company-ispell-setup)
;; }}

(eval-after-load 'company-etags
  '(progn
     ;; insert major-mode not inherited from prog-mode
     ;; to make company-etags work
     (add-to-list 'company-etags-modes 'web-mode)
     (add-to-list 'company-etags-modes 'lua-mode)))


                                        ;(setq company-idle-delay t)
(setq company-idle-delay nil)
(add-hook 'after-init-hook 'global-company-mode)  

(dolist (hook (list ; 13 for specific modes company-mode on
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-common-hook
               'java-mode
               'python-mode-hook
               'csharp-mode
               'swift-mode
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook))
  (add-hook hook 'company-mode))

(defun sucha-install-company-completion-rules ()
  "gtags and dabbref completions for C and C++ mode"
  (company-clear-completion-rules)
  (company-install-dabbrev-completions)
  (company-install-file-name-completions)
  (eval-after-load 'company-gtags-completions
    '(company-install-gtags-completions))
  )

(add-hook
 'c-mode-common-hook
 (lambda ()
   (company-mode 1)
   (sucha-install-company-completion-rules) ; refers to the function
   )
 t)

;; company mode map  ; 7 mute for java-mode
;;(define-key company-mode-map [(tab)] 'indent-for-tab-command) ; tab should NOT be reset to anything else than yas/trigger-key
;(global-set-key [(meta n)] 'company-cycle)
;(global-set-key [(meta p)] 'company-cycle-backwards)
;(global-set-key [(backtab)] 'company-expand-common)
;(global-set-key [?\C-/] 'company-expand-anything) ; M-SPC
;(global-set-key [(meta return)] 'company-expand-common)

(provide 'init-company)
