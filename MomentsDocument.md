# 1. 设计模式
项目使用MVVM设计模式，减轻ViewController的负担。
# 2. 项目结构
- **Config** 网络请求地址配置
- **Request** 网络请求封装
 - **WebImage** 网络图片缓存及管理类
- **Model** 数据模型
- **ViewController** 列表控制器
- **View** 列表cell的UI
- **ViewModel** 获取数据并处理数据逻辑
- **Categories** 分类扩展

# 3. 使用到的开源库
- **AFNetworking** 网络请求
- **MJExtension** json转Model
- **MJRefresh** 下拉刷新、上拉加载更多
- **SDAutoLayout** 代码写UI控件约束
- **DZNEmptyDataSet** 列表加载失败页面处理