#include <array>
#include <cstddef>
#include <cstdint>
#include <functional>

#include <pthread.h>

namespace panic
{

template <std::size_t stack_size>
class Thread {
  public:
    Thread(std::function<void*(void*)> entry, void* user_data)
        : _entry{entry}
        , _user_data{user_data}  {

        pthread_attr_t attribute;
        pthread_t thread;

        pthread_attr_init(&attribute);
        pthread_attr_setstacksize(&attribute, 1024);
        pthread_create(&thread, &attribute, entry_caller, 0);
        pthread_join(thread, 0);
    }

  private:
    static void* entry_caller(void* arg)
    {
        Thread* self = static_cast<Thread*>(arg);
        return self->m_func(self->m_user_data);
    }

    void* _user_data;
    std::function <void*(void*)> _entry;
    std::array<uint8_t, stack_size> _stack{};
};

}  // namespace panic