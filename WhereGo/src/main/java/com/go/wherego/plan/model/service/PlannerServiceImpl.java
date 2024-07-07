package com.go.wherego.plan.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.plan.model.dao.PlannerDao;
import com.go.wherego.plan.model.vo.Planner;

@Service
public class PlannerServiceImpl implements PlannerService {

	@Autowired
	private PlannerDao plannerDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//planner 저장
	@Override
	public int insertPlanner(Planner planner) {
		
		int result = plannerDao.insertPlanner(planner, sqlSession);
		
		return result;
	}

}
