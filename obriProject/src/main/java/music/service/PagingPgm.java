package music.service;

public class PagingPgm {
	private int total;
	private int rowPerPage;
	private int pagePerBlk = 10;  // 하단에 있는 클릭하는 숫자들 10개 기준
	private int currentPage;
	private int startPage;
	private int endPage;
	private int totalPage;

	public PagingPgm(int total, int rowPerPage, int currentPage) {
		this.total = total;
		this.rowPerPage = rowPerPage;
		this.currentPage = currentPage;
		
		totalPage = (int) Math.ceil((double) total / rowPerPage); // 하단에 페이징될 페이지의 갯수
		startPage = currentPage - (currentPage - 1) % pagePerBlk; // 1  ,11 ,21
		endPage = startPage + pagePerBlk - 1;					  // 10 ,20 ,30
		
		if (endPage > totalPage)	// 마지막 페이지가  전체 페이지 보다 많으면 totalPage 페이지가 endPage로 된다
			endPage = totalPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRowPerPage() {
		return rowPerPage;
	}

	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}

	public int getPagePerBlk() {
		return pagePerBlk;
	}

	public void setPagePerBlk(int pagePerBlk) {
		this.pagePerBlk = pagePerBlk;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	@Override
	public String toString() {
		return "PagingPgm [total=" + total + ", rowPerPage=" + rowPerPage + ", pagePerBlk=" + pagePerBlk
				+ ", currentPage=" + currentPage + ", startPage=" + startPage + ", endPage=" + endPage + ", totalPage="
				+ totalPage + "]";
	}
	
	
}
