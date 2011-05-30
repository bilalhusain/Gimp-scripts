(define
	(batch-image-scale pattern width height)
	(let*
		((filelist (cadr (file-glob pattern 1))))
		(gimp-message-set-handler 1)
		(while
			(not (null? filelist))
			(let*
				(
					(filename (car filelist))
					(image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
					(drawable (car (gimp-image-get-active-layer image)))
				)
				(gimp-message (string-append "processing " filename))
				(gimp-image-scale image width height)
				(gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
				(gimp-image-delete image)
			)
			(set! filelist (cdr filelist))
		)
	)
)
