package com.go.wherego.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.member.model.dao.MemberDao;
import com.go.wherego.member.model.vo.Member;


@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Override
	public Member loginMember(Member m) {

		Member loginUser = memberDao.loginMember(sqlSession,m);
		
		return loginUser;
	}
	
	//회원가입 메소드
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession,m);
	}
	@Override
	public int updateMember(Member m) {
		
		return memberDao.updateMember(sqlSession,m);
	}

	@Override
	public int deleteMember(String userId) {
		
		return memberDao.deleteMember(sqlSession,userId);
	}

	@Override
	public int checkId(String checkId) {
		
		return memberDao.checkId(sqlSession,checkId);
	}
	
	
	
	
	
}
