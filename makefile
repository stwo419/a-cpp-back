# 源文件目录、头文件目录、编译产物目录
SRC_DIR := source_file
HDR_DIR := header_file
BUILD_DIR := build

# 所有cpp源码
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
# 目标obj文件，放到build下
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))
# 最终可执行程序名
TARGET := server

# 编译器与编译选项
CXX := g++
CXXFLAGS := -Wall -g -I$(HDR_DIR) -std=c++11

# 链接库：pthread线程库
LDFLAGS := -pthread -lmysqlclient

# 主目标
$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

# 编译cpp生成o文件，自动创建build目录
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 不存在build文件夹就新建
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# 清理
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(TARGET)
