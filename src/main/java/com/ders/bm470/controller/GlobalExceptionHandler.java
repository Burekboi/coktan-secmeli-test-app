package com.ders.bm470.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public ModelAndView handleIllegalArgument(IllegalArgumentException ex) {
        ModelAndView mav = new ModelAndView("test_detail"); // burayı formunun adıyla değiştir
        mav.addObject("errorMessage", ex.getMessage());
        return mav;
    }
}
