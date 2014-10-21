;---------------------------------------;
; JONATHAN MERRITT'S EMACS STARTUP FILE ;
;---------------------------------------;
; Setup:
;
; 1. Create vendor directory:
;   > mkdir -p ~/.emacs.d/vendor
;
; 2. Install milkypostman/powerline (cute status bar / modeline):
;   > cd ~/.emacs.d/vendor
;   > git clone https://github.com/milkypostman/powerline.git
;
; 3. Install ensime (scala mode for emacs):
;   > cd ~/.emacs.d/vendor
;   > wget https://www.dropbox.com/sh/ryd981hq08swyqr/ZiCwjjr_vm/ENSIME%20Releases/ensime_2.10.0-0.9.8.9.tar.gz
;   > tar -xzf ensime_2.10.0-0.9.8.9.tar.gz
;   > rm ensime_2.10.0-0.9.8.9.tar.gz
;
; 4. Install julia mode:
;   > cd ~/.emacs.d/vendor
;   > wget https://raw.github.com/JuliaLang/julia/master/contrib/julia-mode.el

; Default font
(set-default-font "-apple-Inconsolata-light-normal-normal-*-12-*-*-*-m-0-iso10646-1")

; Set fullscreen shortcut key to be M-RET
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (when window-system
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)) ))
(global-set-key (kbd "M-RET") 'toggle-fullscreen)

; Visual customizations
(tool-bar-mode 0)               ; turn off tool bar
(setq inhibit-splash-screen t)  ; no splash
(setq visible-bell 1)           ; visible bell (square in the middle of the screen) - not audio

; Window size
(if (window-system)
    (set-frame-size (selected-frame) 120 30))

; Stop emacs from saving backup files
(setq make-backup-files nil)

; Emacs powerline (cute modeline / status bar graphics)
(add-to-list 'load-path "~/.emacs.d/vendor/powerline")
(require 'powerline)
(set-face-attribute 'powerline-active1 nil :box nil :foreground "LightGrey")
(set-face-attribute 'powerline-active2 nil :box nil)
(set-face-attribute 'mode-line nil :box nil :background "OliveDrab3" :foreground "grey14")
(set-face-attribute 'powerline-inactive1 nil :box nil)
(set-face-attribute 'powerline-inactive2 nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(set-face-attribute 'mode-line-highlight nil :box nil)
(powerline-default-theme)
(add-hook 'window-setup-hook 'powerline-reset)  ; get coloring of arrows correct

; Package mechanism
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa-stable.milkbox.net/packages/") t)
(package-initialize)

; Color theme
(unless (package-installed-p 'color-theme)
  (package-refresh-contents) (package-install 'color-theme))
(require 'cl)
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)
(set-face-background 'region "#304030")

; AUCTeX
(unless (package-installed-p 'auctex)
  (package-refresh-contents) (package-install 'auctex))

; Scala-mode 2
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))

; Column marker
(unless (package-installed-p 'column-marker)
  (package-refresh-contents) (package-install 'column-marker))
(require 'column-marker)
(add-hook 'scala-mode-hook (lambda () (interactive) (column-marker-1 120)))
(column-number-mode)

; Ensime
;(add-to-list 'load-path "~/.emacs.d/vendor/ensime_2.10.0-0.9.8.9/elisp/")
;(require 'ensime)
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

; GHC-mod
(unless (package-installed-p 'ghc)
  (package-refresh-contents) (package-install 'ghc))
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

; Haskell mode
; (unless (package-installed-p 'haskell-mode)
;  (package-refresh-contents) (package-install 'haskell-mode))
; (require 'haskell-mode)
; (custom-set-variables '(haskell-mode-hook '(turn-on-haskell-indentation)))

; Sr-Speedbar
; Producing errors on 2014-01-27.
; Suggest waiting for a time and then try re-enabling.
;(unless (package-installed-p 'sr-speedbar)
;  (package-refresh-contents) (package-install 'sr-speedbar))
;(require 'sr-speedbar)

; Smooth scrolling
(unless (package-installed-p 'smooth-scrolling)
  (package-refresh-contents) (package-install 'smooth-scrolling))
(require 'smooth-scrolling)
; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ; scroll window under mouse
(setq scroll-step 1) ; keyboard scroll one line at a time

; Julia language syntax highlighting
(load "~/.emacs.d/vendor/julia-mode.el")
(require 'julia-mode)

; Arduino mode
(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

; Set parameters for video recording
(defun set-for-recording ()
  "Set up for video screencast (half of 1280x720)"
  (interactive)
  (set-default-font "-apple-Inconsolata-light-normal-normal-*-18-*-*-*-m-0-iso10646-1")
  (powerline-reset)
  (scroll-bar-mode -1)
  (set-frame-size (selected-frame) 100 50) 
)

; Additions to the exec-path and PATH environment variable
(setq exec-path (append exec-path `("/usr/local/bin")))
(setq exec-path (append exec-path `("/Users/merrijo/.cabal/bin")))
(setenv "PATH" (concat "/usr/texbin" ":"
		       "/usr/local/bin" ":"
		       "/Users/merrijo/.cabal/bin" ":"
		       (getenv "PATH")))

; Set JAVA_HOME to use JDK 8
(setq jdk-dir "/Library/Java/JavaVirtualMachines/jdk1.8.0_b87.jdk")
(setq java-home (concat jdk-dir "/Contents/Home"))
(setenv "JAVA_HOME" java-home)

; IDO
(require 'ido)
(ido-mode t)
