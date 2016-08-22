package kr.ac.lamda.domain;

public class Criteria {

	private int page;
	private int rowS;
	private int rowE;
	private int perPageNum;
	
	/*public Criteria(){
		this.page = 1;
		this.rowS = 1;
		this.rowE = 10;
		this.perPageNum=10;
	}*/

	public void setPage(int page){
		
		if(page <= 0){
			this.page = 1;
		
		}
		
		this.page = page;
	}
	
	public void setRowS(int page){
		
			this.rowS=page*10-9;
		
	}
	
	public void setRowE(int page){
		
		this.rowE=page*10;

	}
	
	public int getPage() {
		return page;
	}	
	
	//method for MyBatis SQL Mapper - 
	public int getPageStart() {
		
		return (this.page -1)* this.perPageNum;
	}
	
	//method for MyBatis SQL Mapper 
	public int getPerPageNum(){
		
		return this.perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", rowS=" + rowS + ", rowE=" + rowE + "]";
	}
}


