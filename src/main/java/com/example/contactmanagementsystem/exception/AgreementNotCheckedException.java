package com.example.contactmanagementsystem.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CHECKPOINT , reason = "Not checked the term and condition")
public class AgreementNotCheckedException extends RuntimeException{
    public AgreementNotCheckedException(String message) {
        super(message);
    }
}
