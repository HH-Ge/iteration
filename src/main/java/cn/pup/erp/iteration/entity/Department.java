package cn.pup.erp.iteration.entity;

import java.util.Date;

/**
 * Generator 按 tbl_department 生成的实体类，新增以下属性和方法
 * 属性：creator 和 modifier
 * 方法：addLike()
 *
 * @author HH
 */
public class Department {

    private Integer departmentId;

    private String departmentName;

    private Boolean isValid;

    private Date gmtCreate;

    private Date gmtModified;

    private String creator;

    private String modifier;

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName == null ? null : departmentName.trim();
    }

    public Boolean getIsValid() {
        return isValid;
    }

    public void setIsValid(Boolean isValid) {
        this.isValid = isValid;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier == null ? null : modifier.trim();
    }

    @Override
    public String toString() {
        return "Department{" +
                "departmentId=" + departmentId +
                ", departmentName='" + departmentName + '\'' +
                ", isValid=" + isValid +
                ", creator='" + creator + '\'' +
                ", gmtCreate=" + gmtCreate +
                ", modifier='" + modifier + '\'' +
                ", gmtModified=" + gmtModified +
                '}';
    }

    /**
     * 将需要like的字段加上%%
     * 注意：if中的条件顺序，颠倒会到账空指针
     *
     * @return 加好 % 的查询条件
     */
    public Department addLike() {
        if ((this.getDepartmentName() != null) && (this.getDepartmentName().trim() != "")) {
            this.setDepartmentName("%" + this.getDepartmentName() + "%");
        }
        if ((this.getCreator() != null) && (this.getCreator().trim() != "")) {
            this.setCreator("%" + this.getCreator() + "%");
        }
        if ((this.getModifier() != null) && (this.getModifier().trim() != "")) {
            this.setModifier("%" + this.getModifier() + "%");
        }
        return this;
    }
}