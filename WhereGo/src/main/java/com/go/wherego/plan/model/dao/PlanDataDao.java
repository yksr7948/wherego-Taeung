package com.go.wherego.plan.model.dao;

import java.util.ArrayList;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.plan.model.vo.PlanData;
import com.go.wherego.plan.model.vo.Planner;

@Repository
public class PlanDataDao {

	//planList 저장
	public int insertPlanData(SqlSessionTemplate sqlSession, ArrayList<PlanData> pList) {

		return sqlSession.insert("planDataMapper.insertPlanData", pList);
	}
	
	//플랜들 가져오기
	public ArrayList<PlanData> selectPlanData(SqlSessionTemplate sqlSession, ArrayList<Planner> plannerList) {
		
		ArrayList<PlanData> plansData = new ArrayList<>();
		
		for(int i=0;i<plannerList.size();i++) {
			int plannerNo = plannerList.get(i).getPlannerNo();
					
			plansData.addAll((ArrayList)sqlSession.selectList("planDataMapper.selectPlanData", plannerNo));
		}
		
		
		return plansData;
	}

	
    public ArrayList<PlanData> selectPlanDataByPlannerNo(SqlSessionTemplate sqlSession, int plannerNo) {
        List<PlanData> list = sqlSession.selectList("planDataMapper.selectPlanDataByPlannerNo", plannerNo);
        return new ArrayList<>(list);
    }
}
