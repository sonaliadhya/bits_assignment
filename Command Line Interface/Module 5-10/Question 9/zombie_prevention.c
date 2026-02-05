#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

#define NUM_CHILDREN 3

int main() {
    pid_t pid;
    int i, status;

    printf("Parent process PID: %d\n\n", getpid());

    /* Create multiple child processes */
    for (i = 0; i < NUM_CHILDREN; i++) {
        pid = fork();

        if (pid < 0) {
            perror("fork failed");
            exit(1);
        }

        if (pid == 0) {
            /* Child process */
            printf("Child %d started. PID: %d, Parent PID: %d\n",
                   i + 1, getpid(), getppid());
            sleep(2);   // Simulate some work
            printf("Child %d (PID %d) exiting\n", i + 1, getpid());
            exit(0);
        }
    }

    /* Parent process: clean up terminated children */
    for (i = 0; i < NUM_CHILDREN; i++) {
        pid = wait(&status);
        if (pid > 0) {
            printf("Parent cleaned up child with PID: %d\n", pid);
        }
    }

    printf("\nAll child processes cleaned up. No zombies remain.\n");
    return 0;
}
