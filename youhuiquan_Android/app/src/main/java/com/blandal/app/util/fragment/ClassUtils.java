package com.blandal.app.util.fragment;

import android.content.Context;
import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.AnnotatedElement;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import dalvik.system.DexFile;

/**
 * 查找指定路径下面实现指定接口的全部类
 */
public class ClassUtils {

    /**
     * @param clazz       接口
     * @param packageName 实现类所在的包的包名
     */

    @SuppressWarnings({"rawtypes", "unchecked"})
    public static ArrayList<Class> getAllClassByInterface(Class clazz, String packagePath, String packageName) {
        ArrayList<Class> list = new ArrayList<>();

        // 判断是否是一个接口
        if (clazz.isInterface()) {
            try {
                ArrayList<Class> allClass = getAllClass(packagePath, packageName);
                /**
                 * 循环判断路径下的所有类是否实现了指定的接口 并且排除接口类自己
                 */
                for (int i = 0; i < allClass.size(); i++) {
                    /**
                     * 判断是不是同一个接口
                     */
                    if (clazz.isAssignableFrom(allClass.get(i))) {
                        if (!clazz.equals(allClass.get(i))) {
                            // 自身并不加进去
                            list.add(allClass.get(i));
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("出现异常:" + e.getMessage());
            }
        }
        return list;
    }

    /**
     * 获取应用程序下的所有Dex文件
     *
     * @param packageCodePath 包路径
     * @return Set<DexFile>
     */
    public static Set<DexFile> applicationDexFile(String packageCodePath) {
        Set<DexFile> dexFiles = new HashSet<>();
        File dir = new File(packageCodePath).getParentFile();
        File[] files = dir.listFiles();
        for (File file : files) {
            try {
                String absolutePath = file.getAbsolutePath();
                if (!absolutePath.contains(".")) continue;
                String suffix = absolutePath.substring(absolutePath.lastIndexOf("."));
                if (!suffix.equals(".apk")) continue;
                DexFile dexFile = createDexFile(file.getAbsolutePath());
                if (dexFile == null) continue;
                dexFiles.add(dexFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return dexFiles;
    }

    /**
     * 创建DexFile文件
     *
     * @param path 路径
     * @return DexFile
     */
    public static DexFile createDexFile(String path) {
        try {
            return new DexFile(path);
        } catch (IOException e) {
            return null;
        }
    }

    /**
     * 读取类路径下的所有类
     *
     * @param packageName     包名
     * @param packageCodePath 上下文
     * @return List<Class>
     */
    public static ArrayList<Class> reader(String packageCodePath, String packageName) {
        ArrayList<Class> classes = new ArrayList<>();
        Set<DexFile> dexFiles = applicationDexFile(packageCodePath);
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        for (DexFile dexFile : dexFiles) {
            if (dexFile == null) continue;
            Enumeration<String> entries = dexFile.entries();
            while (entries.hasMoreElements()) {
                try {
                    String currentClassPath = entries.nextElement();
                    if (currentClassPath.contains("cc.jianke.zhaiwanzhuan") && currentClassPath.contains("Fragment")) {//在当前所有可执行的类里面查找包含有该包名的所有类
                        if (currentClassPath == null || currentClassPath.isEmpty() || currentClassPath.indexOf(packageName) != 0)
                            continue;
                        Class entryClass = Class.forName(currentClassPath, true, classLoader);
                        if (entryClass == null) continue;
                        classes.add(entryClass);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return classes;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public static ArrayList<Class> getClassesFromPackage(Context ctx, String pkgName) {
        ArrayList<Class> rtnList = new ArrayList<Class>();
        String[] apkPaths = ctx.getApplicationInfo().splitSourceDirs;// 获得所有的APK的路径
        DexFile dexfile = null;
        Enumeration<String> entries = null;
        String className = null;
        for (String apkPath : apkPaths) {
            try {
                dexfile = new DexFile(apkPath);// 获得编译后的dex文件
                entries = dexfile.entries();// 获得编译后的dex文件中的所有class
                while (entries.hasMoreElements()) {
                    className = (String) entries.nextElement();
                    if (className.startsWith(pkgName) && className.contains("Fragment")) {// 判断类的包名是否符合
                        rtnList.add(Class.forName(className));
                    }
                }
            } catch (ClassNotFoundException | IOException e) {
            } finally {
                try {
                    if (dexfile != null) {
                        dexfile.close();
                    }
                } catch (IOException e) {
                }
            }
        }
        return rtnList;
    }

    /**
     * 从一个指定路径下查找所有的类
     *
     * @param packageName
     * @param packagePath
     */
    private static ArrayList<Class> getAllClass(String packagePath, String packageName) {
        ArrayList<Class> list = new ArrayList<>();
        try {
            DexFile df = new DexFile(packagePath);//通过DexFile查找当前的APK中可执行文件
            Enumeration<String> enumeration = df.entries();
            while (enumeration.hasMoreElements()) {
                String className = enumeration.nextElement();
                if (className.contains(packageName) && className.contains("Fragment")) {//在当前所有可执行的类里面查找包含有该包名的所有类
                    Class clazz = Class.forName(className);
                    list.add(clazz);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (ExceptionInInitializerError e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * @param clazz       注解.class
     * @param context
     * @param packageName
     * @return
     */
    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public static ArrayList<Class> getClassesByAnnotation(Class clazz, Context context, String packageName) {
        ArrayList<Class> list = new ArrayList<>();

        // 判断是否是一个注解
        if (clazz.isAnnotation()) {
            try {
                ArrayList<Class> allClass = getClassesFromPackage(context, packageName);
                /**
                 * 循环判断路径下的所有类是否实现了指定的接口 并且排除接口类自己
                 */
                for (int i = 0; i < allClass.size(); i++) {
                    /**
                     * 判断是否拥有注解clazz
                     */
                    if (hasAnnotation(allClass.get(i), clazz)) {
                        if (!clazz.equals(allClass.get(i))) {
                            // 自身并不加进去
                            list.add(allClass.get(i));
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("出现异常:" + e.getMessage());
            }
        }
        return list;
    }

    /**
     * @param clazz       注解.class
     * @param packagePath
     * @param packageName
     * @return
     */
    public static ArrayList<Class> getClassesByAnnotation(Class clazz, String packagePath, String packageName) {
        ArrayList<Class> list = new ArrayList<>();

        // 判断是否是一个注解
        if (clazz.isAnnotation()) {
            try {
                ArrayList<Class> allClass = getAllClass(packagePath, packageName);
                /**
                 * 循环判断路径下的所有类是否实现了指定的接口 并且排除接口类自己
                 */
                for (int i = 0; i < allClass.size(); i++) {
                    /**
                     * 判断是否拥有注解clazz
                     */
                    if (hasAnnotation(allClass.get(i), clazz)) {
                        if (!clazz.equals(allClass.get(i))) {
                            // 自身并不加进去
                            list.add(allClass.get(i));
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("出现异常:" + e.getMessage());
            }
        }
        return list;
    }

    public static boolean hasAnnotation(AnnotatedElement element, Class annotationType) {
        if (element.isAnnotationPresent(annotationType)) {
            return true;
        }
        return false;
    }

    /**
     * 此方法是根据传入的类或者接口的Class文件，获取里面的所有属性
     *
     * @param fragmentTagClass 传入一个接口或者类Class
     * @return
     */
    public List<String> getTagsFromFragmentTagClass(Class fragmentTagClass) {
        List<String> list = new ArrayList<String>();
        Class a = fragmentTagClass;
        Field[] fields = a.getFields();
        for (Field field : fields) {
            list.add(field.getName());
        }
        return list;
    }
}

