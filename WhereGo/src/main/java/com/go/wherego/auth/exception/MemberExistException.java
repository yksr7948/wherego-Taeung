package com.go.wherego.auth.exception;


import com.go.wherego.member.model.vo.Member;

import lombok.Getter;

@Getter
public class MemberExistException extends Exception{
	private static final long serialVersionUID = 1L;
	//예외처리에 필요한 값을 저장하기 위한 필드 선언
	private Member m; //사용자로부터 입력받은 회원정보를 저장

	public MemberExistException() {
		// TODO Auto-generated constructor stub
	}
	
	//매개변수로 예외 메세지와 예외처리에 필요한 값을 전달받아 필드에 저장 
	public MemberExistException(String message, Member m) {
		super(message);//부모 클래스 Exception의 생성자 호출 - 객체 생성시 메세지 전달 가능
		this.m=m;//클래스 내의 멤버 변수에 값 할당
	}
}
