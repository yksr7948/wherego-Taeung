package com.go.wherego.plan.model.dao;

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
	


}
