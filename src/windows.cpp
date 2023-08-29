#include <GLFW/glfw3.h>

void render_triangle(GLFWwindow* window, int &width, int &height){
    glfwGetFramebufferSize(window, &width, &height);
    glViewport(0, 0, width, height);

}