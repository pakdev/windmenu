#lang racket/base
(require ffi/unsafe
         ffi/unsafe/define)

(provide
 (protect-out make-RECT
              RECT-left
              RECT-top
              RECT-right
              RECT-bottom
              SystemParametersInfoA
              make-POINT
              make-MSG
              MSG-message
              GetMessage
              RegisterHotKey
              UnregisterHotKey

(define user32-lib
  (cond
    [(eq? 'windows (system-type))
     (ffi-lib "user32")]
    [else #f]))

(define-ffi-definer define-user32 user32-lib)

(define-cstruct _RECT
  ([left   _long]
   [top    _long]
   [right  _long]
   [bottom _long]))

(define-user32 SystemParametersInfoA
  (_fun _uint _uint _RECT-pointer _uint
        -> _int))

(define _HWN _pointer)
(define-cstruct _POINT
  ([x _long]
   [y _long]))
(define-cstruct _MSG
  ([hwnd _HWND]
   [message _uint]
   [wParam _pointer]
   [lParam _pointer]
   [time _ulong]
   [pt _POINT-pointer]))

(define-user32 GetMessage
  (_fun _MSG-pointer _HWND _uint _uint
        -> _int))

(define-user32 RegisterHotKey
  (_fun _HWND _int _uint _uint
        -> _int))

(define-user32 UnregisterHotKey
  (_fun _HWND _int
        -> _int))
