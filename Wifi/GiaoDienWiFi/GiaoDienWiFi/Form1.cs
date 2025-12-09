using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;


namespace GiaoDienWiFi
{
    public partial class Form1 : Form
    {
        IPEndPoint ipe;
        Socket server;
        Socket client;
        byte[] datasend = new byte[1]; // Mảng gửi đi
        byte[] datareceive = new byte[1]; // Mảng nhận về
        int count = 0;
        int countRE0 = 0;
        public Form1()
        {
            InitializeComponent();
            Control.CheckForIllegalCrossThreadCalls = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult answer = MessageBox.Show("Do you want to exit the program?", "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (answer == DialogResult.No)
            {
                e.Cancel = true;
            }
            else
            {
                if (button_disconnect.Enabled == true)
                {
                    datasend = Encoding.ASCII.GetBytes("Z"); // Gửi mã ngắt kết nối
                    client.Send(datasend, datasend.Length, SocketFlags.None);
                    server.Close();
                    client.Close();
                }
            }
        }


        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void button_connect_Click(object sender, System.EventArgs e)
        {
            Thread thread = new Thread(Endpoint_Thread);
            thread.IsBackground = true;
            thread.Start();

            textBox_full_IP.BackColor = Color.Yellow;
            textBox_full_IP.Text = "Waiting for device to connect";

            // Khóa IP và Port
            textBox_IP1.Enabled = false;
            textBox_IP2.Enabled = false;
            textBox_IP3.Enabled = false;
            textBoxIP4.Enabled = false;
            textBox_port.Enabled = false;
        }


        void Endpoint_Thread()
        {
            try
            {
                // Thiết lập IPEndpoint và Socket
                string ip = textBox_IP1.Text.Trim() + "." +
                            textBox_IP2.Text.Trim() + "." +
                            textBox_IP3.Text.Trim() + "." +
                            textBoxIP4.Text.Trim();
                int port = int.Parse(textBox_port.Text.Trim());
                ipe = new IPEndPoint(IPAddress.Parse(ip), port);
                server = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

                // Kết nối Socket với IPEndpoint, mở cổng kết nối
                server.Bind(ipe);

                // Lắng nghe từ Client, cho phép kết nối tối đa 10 Client
                server.Listen(10);

                // Chấp nhận kết nối
                client = server.Accept();
                textBox_full_IP.BackColor = Color.Lime; // Hiển thị trạng thái kết nối
                textBox_full_IP.Text = "Connected with: " + client.RemoteEndPoint.ToString();

                Thread thread = new Thread(Receive);
                thread.IsBackground = true;
                thread.Start();

                // Cho phép các nút điều khiển hoạt động
                button_connect.Enabled = false;
                button_disconnect.Enabled = true;
                button_ONRE1.Enabled = true;
                button_OffRE1.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                textBox_full_IP.BackColor = Color.Red; // Hiển thị trạng thái lỗi
                textBox_full_IP.Text = "Not connect";

                // Mở lại IP và Port
                textBox_IP1.Enabled = true;
                textBox_IP2.Enabled = true;
                textBox_IP3.Enabled = true;
                textBoxIP4.Enabled = true;
                textBox_port.Enabled = true;

                // Cấm các nút điều khiển hoạt động
                button_connect.Enabled = true;
                button_disconnect.Enabled = false;
                button_ONRE1.Enabled = false;
                button_OffRE1.Enabled = false;
            }
        }



        private void button_disconnect_Click(object sender, System.EventArgs e)
        {
            try
            {
                datasend = Encoding.ASCII.GetBytes("Z"); // Gửi mã ngắt kết nối
                client.Send(datasend, datasend.Length, SocketFlags.None);
                server.Close();
                client.Close();

                textBox_full_IP.BackColor = Color.Red;
                textBox_full_IP.Text = "Not connect";

                // Mở lại các ô nhập IP và Port
                textBox_IP1.Enabled = true;
                textBox_IP2.Enabled = true;
                textBox_IP3.Enabled = true;
                textBoxIP4.Enabled = true;
                textBox_port.Enabled = true;

                // Vô hiệu hóa các nút điều khiển
                button_connect.Enabled = true;
                button_disconnect.Enabled = false;
                button_ONRE1.Enabled = false;
                button_OffRE1.Enabled = false;
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }


        private void Receive()
        {
            try
            {
                while (true)
                {
                    int temp = client.Receive(datareceive);
                    string s = Encoding.ASCII.GetString(datareceive, 0, temp);
                    if (s == "O")
                    {
                        count++;
                        textBox_counterSW0.Text = count.ToString();
                        pictureBox1.Image = GiaoDienWiFi.Properties.Resources.On1;
                    }else if (s == "S")
                    {
                        count++;
                        textBox_counterSW0.Text = count.ToString();
                        pictureBox1.Image = GiaoDienWiFi.Properties.Resources.th__1_1;
                    }else if (s == "B")
                    {
                        countRE0++;
                        textBoxRE0.Text = countRE0.ToString();
                        pictureBox_RE0.Image = GiaoDienWiFi.Properties.Resources.th__1_1;
                    }else if (s == "C")
                    {
                        countRE0++;
                        textBoxRE0.Text = countRE0.ToString();
                        pictureBox_RE0.Image = GiaoDienWiFi.Properties.Resources.On1;
                    }
 

                   
                }
            }
            catch (Exception)
            {
                client.Close();
            }
        }

        private void button_ONRE1_Click(object sender, System.EventArgs e)
        {
            try
            {
                datasend = Encoding.ASCII.GetBytes("@");
                client.Send(datasend, datasend.Length, SocketFlags.None);
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        
        private void button_OffRE1_Click(object sender, System.EventArgs e)
        {
            try
            {
                datasend = Encoding.ASCII.GetBytes("$");
                client.Send(datasend, datasend.Length, SocketFlags.None);
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        
       
        private void buttonRE0_ON_Click(object sender, EventArgs e)
        {
            try
            {
                datasend = Encoding.ASCII.GetBytes("B");
                client.Send(datasend, datasend.Length, SocketFlags.None);
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

       
        private void buttonRE0_OF_Click(object sender, EventArgs e)
        {
            try
            {
                datasend = Encoding.ASCII.GetBytes("C");
                client.Send(datasend, datasend.Length, SocketFlags.None);
            }
            catch (Exception)
            {
                MessageBox.Show("Check the connection again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void textBox_IP1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }
        private void textBox_IP1_Validated(object sender, EventArgs e)
        {
            if (textBox_IP1.Text == "")
            {
                MessageBox.Show("Blank is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP1.Text = "192";
                textBox_IP1.Focus();
            }
            else if (Int16.Parse(textBox_IP1.Text) < 1)
            {
                MessageBox.Show(textBox_IP1.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP1.Text = "192";
                textBox_IP1.Focus();
            }
            else if (Int16.Parse(textBox_IP1.Text) > 223)
            {
                MessageBox.Show(textBox_IP1.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP1.Text = "192";
                textBox_IP1.Focus();
            }
        }

        private void textBox_IP2_Validated(object sender, EventArgs e)
        {
            if (textBox_IP2.Text == "")
            {
                MessageBox.Show("Blank is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP2.Text = "168";
                textBox_IP2.Focus();
            }
            else if (Int16.Parse(textBox_IP2.Text) < 1)
            {
                MessageBox.Show(textBox_IP2.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP2.Text = "168";
                textBox_IP2.Focus();
            }
            else if (Int16.Parse(textBox_IP2.Text) > 223)
            {
                MessageBox.Show(textBox_IP2.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP2.Text = "168";
                textBox_IP2.Focus();
            }
        }

        private void textBox_IP3_Validated(object sender, EventArgs e)
        {
            if (textBox_IP3.Text == "")
            {
                MessageBox.Show("Blank is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP3.Text = "=2";
                textBox_IP3.Focus();
            }
            else if (Int16.Parse(textBox_IP3.Text) < 1)
            {
                MessageBox.Show(textBox_IP3.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP3.Text = "2";
                textBox_IP3.Focus();
            }
            else if (Int16.Parse(textBox_IP3.Text) > 223)
            {
                MessageBox.Show(textBox_IP3.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_IP3.Text = "2";
                textBox_IP3.Focus();
            }
        }
        private void textBoxIP4_Validated(object sender, EventArgs e)
        {
            if (textBoxIP4.Text == "")
            {
                MessageBox.Show("Blank is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBoxIP4.Text = "140";
                textBoxIP4.Focus();
            }
            else if (Int16.Parse(textBoxIP4.Text) < 1)
            {
                MessageBox.Show(textBoxIP4.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBoxIP4.Text = "140";
                textBoxIP4.Focus();
            }
            else if (Int16.Parse(textBoxIP4.Text) > 223)
            {
                MessageBox.Show(textBoxIP4.Text + " is not a valid entry. Please specify a value between 1 and 223", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBoxIP4.Text = "140";
                textBoxIP4.Focus();
            }
        }

        private void textBox_port_Validated(object sender, EventArgs e)
        {
            if (textBox_port.Text == "")
            {
                MessageBox.Show("Blank is not a valid entry. Please specify a value between 0 and 65535", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_port.Text = "8001";
                textBox_port.Focus();
            }
            else if (Int32.Parse(textBox_port.Text) < 0)
            {
                MessageBox.Show(textBox_port.Text + " is not a valid entry. Please specify a value between 0 and 65535", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_port.Text = "8001";
                textBox_port.Focus();
            }
            else if (Int32.Parse(textBox_port.Text) > 65535)
            {
                MessageBox.Show(textBox_port.Text + " is not a valid entry. Please specify a value between 0 and 65535", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                textBox_port.Text = "8001";
                textBox_port.Focus();
            }
        }

        private void Form1_Load_1(object sender, EventArgs e)
        {

        }











    }
}
