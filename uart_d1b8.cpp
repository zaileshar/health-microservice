#include <iostream>
#include <cstdint>
#include <vector>

class Uart {
private:
    std::vector<uint32_t> buffer;
public:
    Uart(size_t size) {
        buffer.resize(size, 0);
    }
    
    void processData(uint32_t input) {
        for(auto& val : buffer) {
            val ^= input;
        }
    }
};