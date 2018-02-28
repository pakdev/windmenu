#lang racket/gui

(require ffi/unsafe)
(require "win32api.rkt")

(define hotkey 1000)
(define screen-rect (make-RECT 0 0 0 0))
(define msg-pt (make-POINT 0 0))
(define win-msg (make-MSG #f 0 0 0 0 msg-pt))

; Create the menu bar so it's the full width of the desktop
(void (SystemParametersInfoA #x0030 0 screen-rect 0))

(define frame (new (class frame% (super-new)
                     (define/augment (on-close)
                       ;(displayln "Exiting...")
                       (UnregisterHotKey #f hotkey)))
                   [label "Windmenu"]
                   [width (- (RECT-right screen-rect)
                             (RECT-left screen-rect))]
                   [height 30]
                   [x 0]
                   [y 0]
                   [style '(no-resize-border no-system-menu)])) ;no-caption

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
(define ret (RegisterHotKey #f hotkey #x0001 #x44)) ; Hotkey = Alt-d

(send frame show #t)
