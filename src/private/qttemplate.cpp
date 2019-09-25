#include "qttemplate.h"
#include "./ui_qttemplate.h"

QtTemplate::QtTemplate(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::QtTemplate)
{
    ui->setupUi(this);
}

QtTemplate::~QtTemplate()
{
    delete ui;
}
