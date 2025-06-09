#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

// Prototypes
size_t  ft_strlen(const char *s);
char    *ft_strcpy(char *dest, const char *src);
int     ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char    *ft_strdup(const char *s);


static void testft_strlen(void)
{
    printf("===== Testing ft_strlen ===\n");
    const char *empty = "";
    const char *str = "xzhang";
    const char *lstr = "scvwdvdabbefbab";\

    printf("Test 1: empty string: %zu (expected %zu)\n", ft_strlen(empty), strlen(empty));
    printf("Test 2: string: %zu (expected %zu)\n\n", ft_strlen(str), strlen(str));
    printf("Test 3: long string: %zu (expected %zu)\n\n", ft_strlen(lstr), strlen(lstr));
}

static void testft_strcpy(void)
{  
    printf("=== Testing ft_strcpy ===\n");
    char dest[100];
    const char *empty = "";
    const char *lstr = "This is a very long string...";

    ft_strcpy(dest, empty);
    printf("Test 1: empty string: '%s' (expected '%s')\n", dest, empty);
    ft_strcpy(dest, lstr);
    printf("Test 2: long string: '%s' (expected '%s')\n\n", dest, lstr);
}

static void testft_strcmp(void)
{
    printf("=== Testing ft_strcmp ===\n");
    const char *empty = "";
    const char *a = "apple";
    const char *b = "BombardiroCrocodilo";
    const char *c = "CapuccinoAssassino";

    printf("Test 1: both empty: %d (expected 0)\n", ft_strcmp(empty, empty));
    printf("Test 2: first empty: %d (expected negative)\n", ft_strcmp(empty, a));
    printf("Test 3: second empty: %d (expected positive)\n", ft_strcmp(a, empty));
    printf("Test 4: 'apple' vs 'BombardiroCrocodilo': %d (expected positive)\n", ft_strcmp(a, b));
    printf("Test 5: 'BombardiroCrocodilo' vs 'CapuccinoAssassino': %d (expected negative)\n\n", ft_strcmp(b, c));
}


static void testft_strdup(void)
{
    printf("=== Testing ft_strdup ===\n");
    const char *empty = "";
    const char *str = "This is a duplicated string...";
    char *dup;

    dup = ft_strdup(empty);
    printf("Test 1: empty string: '%s' (expected '%s')\n", dup, empty);
    free(dup);

    dup = ft_strdup(str);
    printf("Test 2: string: '%s' (expected '%s')\n\n", dup, str);
    free(dup);
}

static void testft_write(void)
{
    printf("=== Testing ft_write ===\n");
    const char *msg = "Hello World\n";
    int fd = open("testft_write.txt", O_WRONLY | O_CREAT, 0644);
    
    ssize_t ret = ft_write(STDOUT_FILENO, msg, strlen(msg));
    printf("\nTest 1: write to stdout: ret=%zd (expected %zd)\n", ret, (ssize_t)strlen(msg));

    ret = ft_write(fd, msg, strlen(msg));
    printf("Test 2: write to file: ret=%zd (expected %zd)\n", ret, (ssize_t)strlen(msg));

    // 测试错误写入无效 fd
    errno = 0;
    ret = ft_write(999, msg, strlen(msg));
    printf("Test 3: write to invalid fd: ret=%zd (expected -1), errno=%d (expected EBADF)\n\n", ret, errno); //EBADF Bad file descriptor
    close(fd);
}

static void testft_read(void)
{
    printf("=== Testing ft_read ===\n");
    char buf[100];
    int fd = open("testft_write.txt",O_RDONLY);
    ssize_t ret = ft_read(fd, buf, 10);
    buf[ret] = '\0';
    printf("Test 1: read from file: ret=%zd (expected 10), data='%s'\n", ret, buf);

    errno = 0;
    ret = ft_read(999, buf, 10);
    printf("Test 2: read from invalid fd: ret=%zd (expected -1), errno=%d (expected EBADF)\n\n", ret, errno);
    close(fd);
}

int main(void)
{
    char dest[100];
    char buf[100];
    char *copy;
    ssize_t n;

    // ft_strlen
    printf("ft_strlen: %zu (should be 5)\n", ft_strlen("hello"));

    // ft_strcpy
    ft_strcpy(dest, "Libasm!");
    printf("ft_strcpy: %s (should be 'Libasm!')\n", dest);

    // ft_strcmp
    printf("ft_strcmp (abc/abc): %d (should be 0)\n", ft_strcmp("abc", "abc"));
    printf("ft_strcmp (abc/abd): %d (should be <0)\n", ft_strcmp("abc", "abd"));
    printf("ft_strcmp (abd/abc): %d (should be >0)\n", ft_strcmp("abd", "abc"));

    // ft_write
    ft_write(1, "ft_write: Hello!\n", 17);

    // ft_read
    write(1, "ft_read: Type something: ", 25);
    n = ft_read(0, buf, 99);
    buf[n] = '\0';
    printf("You typed: %s\n", buf);

    // ft_strdup
    copy = ft_strdup("Libasm rocks");
    printf("ft_strdup: %s\n", copy);
    free(copy);

    testft_strlen();
    testft_strcpy();
    testft_strcmp();
    testft_strdup();
    testft_write();
    testft_read();
    return 0;
}
