package com.homer.type.history;

import com.homer.type.Trade;
import com.homer.util.core.IHistoryObject;
import org.joda.time.DateTime;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by arigolub on 8/21/16.
 */
@Table(name = "history_trades", schema = "homer")
public class HistoryTrade extends Trade implements IHistoryObject {

    @Column
    private long historyId;
    @Column
    private DateTime historyCreatedDateUTC;
    @Column
    private boolean isDeleted;

    @Override
    public long getHistoryId() {
        return historyId;
    }

    @Override
    public void setHistoryId(long historyId) {
        this.historyId = historyId;
    }

    @Override
    public DateTime getHistoryCreatedDateUTC() {
        return historyCreatedDateUTC;
    }

    @Override
    public void setHistoryCreatedDateUTC(DateTime historyCreatedDateUTC) {
        this.historyCreatedDateUTC = historyCreatedDateUTC;
    }

    @Override
    public boolean getIsDeleted() {
        return isDeleted;
    }

    @Override
    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
}
