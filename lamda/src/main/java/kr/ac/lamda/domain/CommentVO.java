package kr.ac.lamda.domain;

import java.util.Date;

public class CommentVO {

  private Integer seq;
  private Integer parent;
  private Integer seq_user;
  private Integer seq_board;
  private String memo;
  private Date create_date;
  private Date modify_date;

  
public Integer getSeq() {
	return seq;
}


public void setSeq(Integer seq) {
	this.seq = seq;
}


public Integer getParent() {
	return parent;
}


public void setParent(Integer parent) {
	this.parent = parent;
}


public Integer getSeq_user() {
	return seq_user;
}


public void setSeq_user(Integer seq_user) {
	this.seq_user = seq_user;
}


public Integer getSeq_board() {
	return seq_board;
}


public void setSeq_board(Integer seq_board) {
	this.seq_board = seq_board;
}


public String getMemo() {
	return memo;
}


public void setMemo(String memo) {
	this.memo = memo;
}


public Date getCreate_date() {
	return create_date;
}


public void setCreate_date(Date create_date) {
	this.create_date = create_date;
}


public Date getModify_date() {
	return modify_date;
}


public void setModify_date(Date modify_date) {
	this.modify_date = modify_date;
}


@Override
  public String toString() {
    return "BoardVO [seq=" + seq + ", parent=" + parent + ", seq_user=" + seq_user + ", seq_board=" + seq_board + 
    		", memo=" + memo + ", create_date=" + create_date + ", modify_date=" + modify_date +"]";
  }

}
