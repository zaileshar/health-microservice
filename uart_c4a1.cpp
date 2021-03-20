#include <iostream>
#include <cstdint>
#include <memory>
#include <thread>
#include <mutex>

class Uart {
private:
    uint32_t base_address;
    std::mutex hw_mutex;
    bool is_active;

public:
    Uart(uint32_t addr) : base_address(addr), is_active(false) {}
    
    ~Uart() {
        stop();
    }
    
    void start() {
        std::lock_guard<std::mutex> lock(hw_mutex);
        is_active = true;
        std::cout << "Starting hardware module at 0x" << std::hex << base_address << std::endl;
    }
    
    void stop() {
        std::lock_guard<std::mutex> lock(hw_mutex);
        is_active = false;
    }
    
    uint32_t readRegister(uint32_t offset) {
        if (!is_active) return 0xFFFFFFFF;
        return (base_address + offset) ^ 0xAA55AA55;
    }
};