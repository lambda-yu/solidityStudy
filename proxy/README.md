# 文件说明

- myProxy.sol： 代理合约
- Implementation： 被代理合约
- Implementation-new: 被代理合约（方法有些不同，用于测试代理合约切换）
- client.sol: solidity 模拟客户端调用
- client.py: py web3 模拟调用



# 部署顺序

合约无部署顺序





# 食用方法

1. 部署所有合约
2. 代理合约中使用 setImplementation 设置被代理合约address（Implementation 合约address）
3. client合约使用 setContract 设置调用的目的合约address（此处设为代理合约address）
4. 在client 中运行setA 或者getA 得到想要的结果





#  注意

测试发现数据是存储在代理合约(myProxy)中而非被代理合约(Implementation)中