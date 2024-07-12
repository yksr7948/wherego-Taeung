package com.go.wherego.plan.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.go.wherego.plan.model.vo.Planner;

@Repository
public class PlannerDao {

	//플래너 저장
	public int insertPlanner(Planner planner, SqlSessionTemplate sqlSession) {
		
		int result = sqlSession.insert("plannerMapper.insertPlanner", planner);
		
		return result;
	}
	
	//planner List 가져오기
	public ArrayList<Planner> selectPlanner(String userId, SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("plannerMapper.selectPlanner", userId);
	}
	
	public Planner selectPlannerByNo(int plannerNo, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("plannerMapper.selectPlannerByNo", plannerNo);
	}
	
	//플래너 삭제하기
	public int deletePlanner(int plannerNo, SqlSessionTemplate sqlSession) {

		return sqlSession.delete("plannerMapper.deletePlanner", plannerNo);
	}


}
