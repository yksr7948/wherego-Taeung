package com.go.wherego.plan.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.go.wherego.plan.model.vo.PlanData;

@Repository
public class PlanDataDao {

	//planList 저장
	public int insertPlanData(SqlSessionTemplate sqlSession, ArrayList<PlanData> pList) {

		return sqlSession.insert("planDataMapper.insertPlanData", pList);
	}

}
