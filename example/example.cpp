#include <arpa/inet.h>
#include <stdio.h>

#include <initializer_list>
#include <iostream>

#include <QByteArray>
#include <QString>
#include <QStringList>

#include <../RelativeExternalProjectHeader.h>
#include <ExternalProjectHeader.h>

#include "../RelativeLocalProjectHeader.h"
#include "LocalProjectHeader.h"

int main(void)
{
    std::cout << "Hello, world!" << std::endl;

    // This is intentionally formatted incorrectly
    if (1 == 1) { int i = 2; }
}
