#lang racket/base
(require ffi/unsafe
         ffi/unsafe/define)

(provide make-RECT)
(provide RECT-left)
(provide RECT-top)
(provide RECT-right)
(provide RECT-bottom)
(provide SystemParametersInfoA)
(provide RegisterHotKey)
(provide UnregisterHotKey)

(define user32-lib
  (cond
    [(eq? 'windows (system-type))
     (ffi-lib "user32")]
    [else #f]))

(define-ffi-definer define-user32 user32-lib)

(define-cstruct _RECT
  ([left _long]
   [top _long]
   [right _long]
   [bottom _long]))

(define _HWND-pointer (_cpointer 'HWND))

(define-user32 SystemParametersInfoA
  (_fun _uint _uint _RECT-pointer _uint
        -> _int))

(define-user32 RegisterHotKey
  (_fun _HWND-pointer _int _uint _uint
        -> _int))

(define-user32 UnregisterHotKey
  (_fun _HWND-pointer _int
        -> _int))
