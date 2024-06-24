package com.go.wherego.auth.exception;

import lombok.Getter;

@Getter
public class MemberNotFoundException extends Exception{
	private static final long serialVersionUID = 1L;
	public MemberNotFoundException() {
		
	}

	public MemberNotFoundException(String message) {
		super(message);
	}
}
