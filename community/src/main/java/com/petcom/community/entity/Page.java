package com.petcom.community.entity;

/**
 * Page for discuss post
 */
public class Page {

    // current page
    private int current = 1;

    // limit number for display
    private int limit = 10;

    // total data (calculate total number of page we will have)
    private int rows;

    // search index
    private String path;

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        if(current >= 1) {
            this.current = current;
        }
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        if(limit >= 1 && limit <= 100) {
            this.limit = limit;
        }
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        if(rows >= 0) {
            this.rows = rows;
        }
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Get current page's start line
     * @return
     */
    public int getOffset() {
        // current * limit - limit
        return (current - 1) * limit;
    }

    /**
     * Get total number page
     * @return
     */
    public int getTotal() {
        // rows / limit [+1]
        if ( rows % limit == 0 ) {
            return rows / limit;
        } else {
            return rows / limit + 1;
        }
    }

    /**
     * Get the start page number
     * @return
     */
    public int getFrom() {
        int from = current - 2;
        return from < 1 ? 1 : from;

    }

    /**
     * Get the end page number
     * @return
     */
    public int getTo() {
        int to = current + 2;
        int total = getTotal();
        return to > total ? total : to;
    }
}
