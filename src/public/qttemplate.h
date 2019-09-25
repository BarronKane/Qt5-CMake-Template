#ifndef QT_TEMPLATE_H
#define QT_TEMPLATE_H

#include <QWidget>

QT_BEGIN_NAMESPACE
namespace Ui { class QtTemplate; }
QT_END_NAMESPACE

class QtTemplate : public QWidget
{
    Q_OBJECT

public:
    QtTemplate(QWidget *parent = nullptr);
    ~QtTemplate();

private:
    Ui::QtTemplate *ui;
};

#endif // QT_TEMPLATE_H
