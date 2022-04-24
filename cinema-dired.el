(defgroup cinema-dired nil
  "Use dired to select a video or movie to watch"
  :group 'multimedia)

(defcustom cinema-dired-default-directory "~/Sync/Videos/"
  "Socket file path."
  :type 'string
  :group 'cinema-dired)

(define-minor-mode cinema-dired-mode
  "Allows you to use normal conventional keybindings to play
movies in a special `cinema-dired-library' buffer which is set by
default as ~/movies"
  :lighter " cinema"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "D") 'play-movie)
	    (define-key map (kbd "RET") 'play-movie)
	    (define-key map (kbd "s") 'search-movie)
            map)
  (defun play-movie ()
    (interactive)
    (dired-do-async-shell-command "mpv " nil (dired-get-marked-files)))
  (defun search-movie ()
    "Searches the movie based on file name, expects file to named in a readable format"
    (interactive)
    (setq search-string (concat "firefox --search " "\'" (file-name-base (car (dired-get-marked-files))) "\'"))
    (async-shell-command search-string)))

(defun jump-to-cinema-dired ()
  (interactive)
  (dired cinema-dired-default-directory)
  (when (string-match-p (file-truename cinema-dired-default-directory)
                        (file-truename default-directory))
    (cinema-dired-mode)))

(provide 'cinema-dired)
;;; cinema-dired.el ends here

