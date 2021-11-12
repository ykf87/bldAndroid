package com.jiankang.gouqi.ui.my.activity;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.util.TypedValue;
import android.widget.TextView;

import androidx.viewpager.widget.ViewPager;

import com.flyco.tablayout.SlidingTabLayout;
import com.flyco.tablayout.listener.OnTabSelectListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.ui.my.adpter.MyTaskClassifyAdapter;
import com.jiankang.gouqi.util.DisplayUtil;

import static com.jiankang.gouqi.common.enums.MyTaskClassifyEnum.ALL;
import static com.jiankang.gouqi.common.enums.MyTaskClassifyEnum.COMPELETE;
import static com.jiankang.gouqi.common.enums.MyTaskClassifyEnum.IN_PROGRESS;
import static com.jiankang.gouqi.common.enums.MyTaskClassifyEnum.IN_REVIEW;
import static com.jiankang.gouqi.common.enums.MyTaskClassifyEnum.REFUSE;

/**
 * @author: ljx
 * @createDate: 2020/11/19  9:36
 */
public class MyTaskActivity extends BaseMvpActivity {

    @BindView(R.id.sliding_tab)
    SlidingTabLayout slidingTab;
    @BindView(R.id.view_pager)
    ViewPager viewPager;
    private int curTab = 0;
    public static final String EXTRA_POSITION = "extra_position";
    private String[] mHeaders = {ALL.getDesc(), IN_PROGRESS.getDesc(), IN_REVIEW.getDesc(), REFUSE.getDesc(), COMPELETE.getDesc()};
    private List<Integer> classifyList = new ArrayList<>();


    public static void launch(Context context, int postion) {
        Intent intent = new Intent(context, MyTaskActivity.class);
        intent.putExtra(EXTRA_POSITION, postion);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_my_task;
    }

    @Override
    public void initView() {
        setEnableGesture(false);
        initViewPager();
    }


    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {
        curTab = getIntent().getIntExtra(EXTRA_POSITION,0);
        slidingTab.setCurrentTab(curTab);
    }

    public void setData() {
        classifyList.add(ALL.getCode());
        classifyList.add(IN_PROGRESS.getCode());
        classifyList.add(IN_REVIEW.getCode());
        classifyList.add(REFUSE.getCode());
        classifyList.add(COMPELETE.getCode());
    }


    private void initViewPager() {
        setData();
        viewPager.setAdapter(new MyTaskClassifyAdapter(getSupportFragmentManager(), classifyList));
        viewPager.setOffscreenPageLimit(3);
        slidingTab.setViewPager(viewPager, mHeaders);
        updateTabView(0);
        slidingTab.setOnTabSelectListener(new OnTabSelectListener() {
            @Override
            public void onTabSelect(int position) {
                updateTabView(position);
            }

            @Override
            public void onTabReselect(int position) {

            }
        });
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                updateTabView(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
    }

    /**
     * 选中改变tab字体大小
     *
     * @param position
     */
    private void updateTabView(int position) {
        int tabCount = slidingTab.getTabCount();
        for (int i = 0; i < tabCount; i++) {
            TextView title = slidingTab.getTitleView(i);
            if (i == position) {
                Drawable drawable = mContext.getResources().getDrawable(R.drawable.bg_tab_indicate);
                drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
                title.setCompoundDrawables(null,null,null,drawable);
                title.setCompoundDrawablePadding(10);
                title.setTextSize(TypedValue.COMPLEX_UNIT_PX, DisplayUtil.sp2px(this, 18));
            } else {
                Drawable drawable = mContext.getResources().getDrawable(R.drawable.bg_tab_indicat_white);
                drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
                title.setCompoundDrawables(null,null,null,drawable);
                title.setCompoundDrawablePadding(10);
                title.setTextSize(TypedValue.COMPLEX_UNIT_PX, DisplayUtil.sp2px(this, 14));
            }
        }
    }
}
