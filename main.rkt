#lang racket/gui

(require ffi/unsafe)
(require "win32api.rkt")

(define hotkey 1000)
(define null-pointer (_cpointer/null 'NULL))

; Create the menu bar so it's the full width of the desktop
(define screen-rect (make-RECT 0 0 0 0))
(void (SystemParametersInfoA #x0030 0 screen-rect 0))

(define frame (new (class frame% (super-new)
                     (define/augment (on-close)
                       (UnregisterHotKey null-pointer hotkey)))
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

;(define hwnd (send frame get-client-handle))
(define ret (RegisterHotKey null-pointer hotkey #x0001 #x44))
(displayln ret)

(send frame show #t)
