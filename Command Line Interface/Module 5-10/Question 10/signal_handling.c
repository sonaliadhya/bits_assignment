#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

pid_t parent_pid;

/* Signal handlers */
void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM (signal %d). Performing cleanup...\n", sig);
    printf("Exiting gracefully due to SIGTERM.\n");
    exit(0);
}

void handle_sigint(int sig) {
    printf("\nParent received SIGINT (signal %d). Ignoring this signal.\n", sig);
    printf("Parent continues running.\n");
}

int main() {
    parent_pid = getpid();

    /* Set up signal handlers */
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent PID: %d\n", parent_pid);

    /* First child: send SIGTERM after 5 seconds */
    pid_t child1 = fork();
    if (child1 < 0) {
        perror("fork failed");
        exit(1);
    }
    if (child1 == 0) {
        sleep(5);
        printf("Child 1 sending SIGTERM to parent...\n");
        kill(parent_pid, SIGTERM);
        exit(0);
    }

    /* Second child: send SIGINT after 10 seconds */
    pid_t child2 = fork();
    if (child2 < 0) {
        perror("fork failed");
        exit(1);
    }
    if (child2 == 0) {
        sleep(10);
        printf("Child 2 sending SIGINT to parent...\n");
        kill(parent_pid, SIGINT);
        exit(0);
    }

    /* Parent process runs indefinitely */
    while (1) {
        printf("Parent running... PID %d\n", parent_pid);
        sleep(1);
    }

    return 0;
}
