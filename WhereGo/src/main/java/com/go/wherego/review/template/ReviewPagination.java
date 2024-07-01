package com.go.wherego.review.template;

import com.go.wherego.review.model.vo.ReviewPage;

public class ReviewPagination {
	public static ReviewPage getReviewPage(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		int startPage = (currentPage-1)/pageLimit * pageLimit+1; 
		int endPage = startPage+pageLimit-1;
		
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		
		ReviewPage pi = new ReviewPage(listCount,currentPage,pageLimit,boardLimit,maxPage,startPage,endPage);
		
		return pi; 
	}
}
