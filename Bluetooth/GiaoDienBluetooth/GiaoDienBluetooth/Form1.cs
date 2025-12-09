using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.Xml;

namespace GiaoDienBluetooth
{
    public partial class Form1 : Form
    {
        String ReceiveData = String.Empty; // bien chuoi nhan ve
        String TramsmitData = String.Empty; // bien chuoi truyen di
        int Count = 0;
        public Form1()
        {
            InitializeComponent();
        }
        
        
        private void Form1_Load(object sender, EventArgs e)
        {
            // Đọc thông tin các cổng COM có trong PC.

            // Lưu ý: Bổ sung khai báo using: System.IO và System.IO.Ports
            string[] ports = SerialPort.GetPortNames();

            // Thêm tên của tất cả các cổng vào mục COM Port.
            foreach (string port in ports)
            {
                comboBox_Port.Items.Add(port);
            }
        }

        //xu ly dong giao dien
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult answer = MessageBox.Show(
                "Do you want to exit the program?",
                "Question",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question
            );

            if (answer == DialogResult.No)
            {
                e.Cancel = true;
            }
            else
            {
               
                if (serial_port != null && serial_port.IsOpen)
                {
                    serial_port.Close();
                }
            }
        }



        private void textBox_SW_TextChanged(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void comboBox_Port_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Đóng cổng COM đã chọn trước đó.
            if (serial_port.IsOpen)
            {
                serial_port.Close();
            }

            // Hiệu chỉnh màu và thông tin trạng thái
            textBox_Status.BackColor = Color.Red;
            textBox_Status.Text = "Disconnected";

            // Lấy số cổng COM đã chọn
            serial_port.PortName = comboBox_Port.Text;
        }
        
        
        // Xử lý để cập nhật các cổng COM
        private void comboBox_Port_Click(object sender, EventArgs e)
        {
            // Xóa danh sách cổng COM trước khi cập nhật
            comboBox_Port.Items.Clear();

            // Lấy danh sách cổng COM hiện có
            string[] ports = SerialPort.GetPortNames();

            // Cập nhật lại tên các cổng COM mới
            foreach (string port in ports)
            {
                comboBox_Port.Items.Add(port);
            }
        }

        private void button_connect_Click(object sender, EventArgs e)
        {
            // Kiểm tra đã chọn cổng COM chưa
            if (comboBox_Port.Text == "")
            {
                MessageBox.Show("Select COM Port.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            // Xử lý mở cổng COM đã chọn
            try
            {
                if (serial_port.IsOpen)
                {
                    MessageBox.Show("COM Port is connected and ready to use.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    serial_port.Open(); // Mở cổng COM
                    textBox_Status.BackColor = Color.LightGreen; // Hiệu chỉnh màu và thông tin
                    textBox_Status.Text = "Connecting...";

                    MessageBox.Show(comboBox_Port.Text + " is connected.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    comboBox_Port.Enabled = false;

                    ReceiveData = String.Empty;
                    TramsmitData = String.Empty;
                }
            }
            catch (Exception)
            {
                // Xử lý lỗi khi không tìm thấy thiết bị
                textBox_Status.BackColor = Color.Red;
                textBox_Status.Text = "Disconnected";
                MessageBox.Show("COM Port is not found. Please check your COM or Cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_disconnect_Click(object sender, EventArgs e)
        {
            try
            {
                if (serial_port.IsOpen) // Kiểm tra nếu cổng đang mở
                {
                    serial_port.Close(); // Đóng cổng COM
                    textBox_Status.BackColor = Color.Red;
                    textBox_Status.Text = "Disconnected";
                    MessageBox.Show("COM Port is disconnected.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    comboBox_Port.Enabled = true;
                }
                else
                {
                    MessageBox.Show("COM Port is already disconnected. Please reconnect to use.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Disconnection error. Unable to disconnect.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_ONRE1_Click(object sender, EventArgs e)
        {
            try
            {
                if (serial_port.IsOpen) // Kiểm tra nếu cổng đang mở
                {
                    TramsmitData = "@";
                    serial_port.Write(TramsmitData); // Gửi dữ liệu
                }
                else
                {
                    textBox_Status.BackColor = Color.Red;
                    textBox_Status.Text = "Disconnected";
                    MessageBox.Show("COM Port is not connected. Please reconnect to use.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The control appears to have an error. Action cannot be completed.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_OffRE1_Click(object sender, EventArgs e)
        {
            try
            {
                if (serial_port.IsOpen)
                {
                    TramsmitData = "$";
                    serial_port.Write(TramsmitData);
                }
                else
                {
                    textBox_Status.BackColor = Color.Red;
                    textBox_Status.Text = "Disconnected";
                    MessageBox.Show("COM Port is not connected. Please reconnect to use.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The control appears to have an error. Action cannot be completed.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void serial_port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            ReceiveData = serial_port.ReadExisting();
            this.Invoke(new EventHandler(DoUpdate));
        }

        private void DoUpdate(object sender, EventArgs e)
        {
            if (ReceiveData == "O")
            {
                pictureBox1.Image = Properties.Resources.On;
            }
            else if (ReceiveData == "F")
            {
                pictureBox1.Image = Properties.Resources.th__1_;
            }
            else if (ReceiveData == "S")
            {
                Count++;
                textBox_SW.Text = Count.ToString();
            }


        }



    }
}
