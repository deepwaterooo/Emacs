;;; ajc-java-complete-my-config-example.el --- Auto Java Completion for GNU Emacs
        
 ;;{{{ yasnippet ������

;;;yasnippet ,a autocomplete plugins
  
(require 'yasnippet) ;; 
(yas/initialize)
;(yas/load-directory (concat joseph_site-lisp_install_path  "~/.emacs.d/elpa/yasnippet-0.8.0/snippets/"))
(setq yas/prompt-functions '( yas/dropdown-prompt yas/x-prompt  yas/ido-prompt yas/completing-prompt)) ;;������ʾ��ʽ���ı�/X
;;}}}

;;{{{  auto-complete ������

  
(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories (concat joseph_site-lisp_install_path  "auto-complete-1.3/ac-dict/") )
(ac-config-default)
;; After completion is started, operations in the following table will be enabled temporarily
;;�⼸��������ʱ�ģ���ȫ��ϻἴ������
;; TAB,  C-i 	ac-expand 	Completion by TAB         
;; RET,  C-m 	ac-complete 	Completion by RET  ͬTAB���������Ǽ����ģ�Ҳ����ɲ�ȫ�Ĳ�ȫ
;; down, M-n 	ac-next 	Select next candidate   ѡ����һ�������޸�ΪC-n
;; up,   M-p 	ac-previous 	Select previous candidate  
;; C-?,  f1 	ac-help 	Show buffer help       
;; C-s �ڳ��ֺ�ѡ��󣬿���C-s ���й��ˣ�ֻ������Ҫ��ѡ��
(setq ac-use-menu-map t) ;;ֻ�ڲ˵����ֵĳ�ʱ����C-n C-p ѡ��˵��Ĳ���
(define-key ac-menu-map "\C-n" 'ac-next) ;;ѡ����һ����ѡ��
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-menu-height 20);;���ò˵����ĸ߶�20��
;; that is a case that an user wants to complete without inserting any character or
;; a case not to start auto-complete-mode automatically by settings
;;������˵�ڻ�û�е����κ��ַ���ʱ��,����Ĭ��û����auto-complete-mode ʱ��ʹ�������ݼ����в�ȫ
;(define-key ac-mode-map (kbd "M-1") 'auto-complete)
(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(setq ac-use-quick-help nil) ;;����ʾ������Ϣ,Ĭ�������õ�
;;; (setq ac-quick-help-delay 10)  ;;����������ʾ�������ӳ�
;;;���������������
;;; (setq ac-auto-start nil);; ����������Զ���ȫ�����ac-set-trigger-key ʹ��
;; (ac-set-trigger-key "TAB")   ;;��ac-auto-start=nil ʱ�ĸ���������ȫ
;;(setq ac-auto-start 4)  ;;���õ����뼸���ַ���ʼ���в�ȫ
;;(ac-use-comphist nil) Ĭ�ϻ�����û�����Ƶ�ȵ�����ѡ��˳�򣬲����ÿɽ���֮
;(setq ac-comphist-file  (concat joseph_root_install_path "cache/ac-comphist.dat"))  ;; modified ehre

;;ʹ���ֵ� ~/.dict 
;;�������������,һ��������1
;(setq ac-user-dictionary '("aaa" "bbb"))
 ;auto-complete-mode won't be enabled automatically for modes that are not in ac-modes. So you need to set if necessary:
;;��jde-mode ���뵽ac-modes ,auto-complete ֻ��ac-modes �е�mode ���������Ĭ��û�����ȥ�����ֹ�����
(add-to-list 'ac-modes 'jde-mode)
(add-to-list 'ac-modes 'java-mode)

;(setq ac-ignore-case 'smart);; ���ܵĴ����Сд��ƥ�� �����д�д��ĸ��ʱ�򲻺��Դ�Сд��
(setq ac-ignore-case nil)
;;dwim  do what i mean 
;; * After selecting candidates, TAB will behave as RET
;; * TAB will behave as RET only on candidate remains
;;����C-n c-p ѡ�к�ѡ��ʱtab ����Ϊreturn ����Ϊ������������
(setq ac-dwim  t)

;; (defun my_ac-java-mode-setup ()
;;        (setq ac-sources '( ac-source-filename
;;                            ac-source-files-in-current-dir
;;                            ac-source-yasnippet
;;                            ac-source-semantic
;;                            ac-source-semantic-raw
;;                            ac-source-gtags 
;;                            ac-source-abbrev 
;;                            ac-source-dictionary
;;                             )))
;; (add-hook 'java-mode-hook 'my_ac-java-mode-setup)

; (require 'auto-complete+)
 (require 'auto-complete)
;; add (ac+-apply-source-elisp-faces) to your emacs-lisp-mode-hook.
(setq ac+-filename-ignore-regexp "^#.*#$\\|.*~$\\|^\\./?$\\|^\\.\\./?$\\|^.svn\\|^CVS$\\|^.git$")
;(add-hook 'emacs-lisp-mode-hook 'ac+-apply-source-elisp-faces)

;;}}}
;;{{{ Auto Java Complete

;;my config file
(add-to-list 'load-path "~/.emacs.d/auto-java-complete")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

;;}}}
