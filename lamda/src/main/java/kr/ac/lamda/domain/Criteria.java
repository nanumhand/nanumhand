package kr.ac.lamda.domain;

public class Criteria {

	private int page;
	private int rowS;
	private int rowE;
	
	public Criteria(){
		this.page = 1;
		this.rowS = 1;
		this.rowE = 10;
	}

	public void setPage(int page){
		
		if(page <= 0){
			this.page = 1;
			return;
		}
		
		this.page = page;
	}
	
	public void setRowS(int page){
		
			this.rowS=page*10-9;
			return;
	}
	
	public void setRowE(int page){
		
		this.rowE=page*10;
		return;
	}
	
	public int getPage() {
		return page;
	}	
	
	//method for MyBatis SQL Mapper - 
	public int getPageStart() {
		
		return (this.page -1)* 10;
	}
	
	//method for MyBatis SQL Mapper 
	public int getPerPageNum(){
		
		return 10;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", rowS=" + rowS + ", rowE=" + rowE + "]";
	}
}


