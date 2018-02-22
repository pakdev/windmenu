#lang racket/gui

(require "win32api.rkt")

; Create the menu bar so it's the full width of the desktop
(define screen-rect (make-RECT 0 0 0 0))
(void (SystemParametersInfoA #x0030 0 screen-rect 0))

(define frame (new frame%
                   [label "Windmenu"]
                   [width (- (RECT-right screen-rect)
                             (RECT-left screen-rect))]
                   [height 30]
                   [x 0]
                   [y 0]
                   [style '(no-resize-border no-caption no-system-menu)]))

(define panel (new horizontal-panel%
                   [parent frame]
                   [alignment '(left center)]))

(define text-field (new text-field%
                        [label "run:"]
                        [parent panel]
                        [init-value ""]
                        [style '(single horizontal-label)]
                        [stretchable-width #f]
                        [min-width 200]
                        [callback (lambda (sender event) (displayln (send sender get-value)))]))

(send frame show #t)
