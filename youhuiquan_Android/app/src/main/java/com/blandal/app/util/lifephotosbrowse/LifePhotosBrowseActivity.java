package com.blandal.app.util.lifephotosbrowse;

import androidx.core.content.ContextCompat;
import androidx.viewpager.widget.PagerAdapter;
import androidx.viewpager.widget.ViewPager;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.io.Serializable;
import java.util.List;

import com.blandal.app.R;
import com.blandal.app.base.BaseActivity;
import com.blandal.app.util.GlideUtil;
import com.blandal.app.util.StatusBarUtil;

public class LifePhotosBrowseActivity extends BaseActivity implements View.OnClickListener {

    private HackyViewPager mViewPager;

    private List<LifePhotoEntity> imgs;

    /**
     * 跳到指定页数
     */
    private int index;

    /**
     * 占位图片
     */
    private Bitmap itemTemporary;

    private LifePhotoEntity currPointData;
    /**
     * 是否删除了图片
     */
    private boolean isDelete;

    private boolean isBrowseOnly;

    @Override
    protected void setStatusBar() {
        StatusBarUtil.setColor(this, ContextCompat.getColor(this, R.color.black), 0);
    }


    public static void launch(Context context, List<LifePhotoEntity> list, int index) {
        if (list == null || list.size() == 0) {
            return;
        }
        Intent intent = new Intent(context, LifePhotosBrowseActivity.class);
        intent.putExtra("imgs", (Serializable) list);
        if (index < 0 || list.size() >= index) {
            index = 0;
        }
        intent.putExtra("index", index);
        context.startActivity(intent);
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        super.setEnableGesture(false);

        setContentView(R.layout.activity_life_photos_browse);

        findViewById(R.id.imgReturn).setOnClickListener(this);

        findViewById(R.id.imgDelete).setOnClickListener(this);

        imgs = (List<LifePhotoEntity>) getIntent().getSerializableExtra("imgs");

        index = getIntent().getIntExtra("index", 0);

        isBrowseOnly = getIntent().getBooleanExtra("isBrowseOnly", true);

        if (isBrowseOnly) {
            findViewById(R.id.imgDelete).setVisibility(View.GONE);
        }

        if (imgs == null || imgs.size() < 1) {
            return;
        }

        setViewImg(imgs.size(), index);

        mViewPager = (HackyViewPager) findViewById(R.id.viewPageImg);

        mViewPager.setAdapter(new SamplePagerAdapter());

        mViewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {

            @Override
            public void onPageScrollStateChanged(int arg0) {
            }

            @Override
            public void onPageScrolled(int arg0, float arg1, int arg2) {
            }

            @Override
            public void onPageSelected(int index) {
                setViewImg(imgs.size(), index);
            }
        });
        if (index != 0) {
            mViewPager.setCurrentItem(index);
        }
    }

    private void setViewImg(int count, int selIndex) {

        TextView txtNewsIndex = (TextView) findViewById(R.id.txtNewsIndex);

        txtNewsIndex.setText(String.format("%s/%s", selIndex + 1, count));

        currPointData = imgs.get(selIndex);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            default:
                break;
            case R.id.imgReturn:
                finish();
                break;
            case R.id.imgDelete:
//                CommonDialog confirm = CommonDialog.newInstance("确定要删除该张生活照吗？",
//                        "取消", "确定");
//                confirm.setOnDialogClickListener(new CommonDialog.OnDialogClickListener() {
//                    @Override
//                    public void onStartBtnDefaultCancelClick() {
//
//                    }
//
//                    @Override
//                    public void onEndBtnDefaultConfirmClick() {
//                        deleteImg();
//                    }
//                });
//                confirm.show(getSupportFragmentManager(),"dialog_confirm");
                break;
        }
    }

    private void deleteImg() {


    }

    @Override
    public void finish() {
        if (isDelete) {
//            Intent intent = new Intent();
//            intent.putExtra("currimgs", (Serializable) imgs);
//            setResult(FinalActivityReturn.LifePhotosBrowseActivityReturn, intent);
//            EventBusManager.getInstance().post(new ResumeUpdateEvent(8));
        }
        super.finish();
    }

    @Override
    protected void onDestroy() {

        super.onDestroy();

        if (itemTemporary != null) {
            itemTemporary.recycle();
        }
    }

    protected void refreshMet() {

    }

    private class SamplePagerAdapter extends PagerAdapter {

        @Override
        public int getCount() {
            return imgs.size();
        }

        @Override
        public View instantiateItem(ViewGroup container, int position) {

            MyPhotoView photoView = new MyPhotoView(container.getContext());

//            if (itemTemporary == null) {
//                itemTemporary = ImageFactory.readBitMap(mContext,
//                        R.drawable.img_default);
//            }

            photoView.setImageBitmap(itemTemporary);

            // Now just add PhotoView to ViewPager and return it
            container.addView(photoView, ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT);

            GlideUtil.loadImage(mContext, imgs.get(position).getLife_photo(), photoView);
            return photoView;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((View) object);
        }

        @Override
        public boolean isViewFromObject(View view, Object object) {
            return view == object;
        }

    }
}
