namespace GiaoDienBluetooth
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.Button button_connect;
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.textBox_Status = new System.Windows.Forms.TextBox();
            this.button_disconnect = new System.Windows.Forms.Button();
            this.label_ComPort = new System.Windows.Forms.Label();
            this.comboBox_Port = new System.Windows.Forms.ComboBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label_counter = new System.Windows.Forms.Label();
            this.textBox_SW = new System.Windows.Forms.TextBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button_OffRE1 = new System.Windows.Forms.Button();
            this.button_ONRE1 = new System.Windows.Forms.Button();
            this.serial_port = new System.IO.Ports.SerialPort(this.components);
            button_connect = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.textBox_Status);
            this.groupBox1.Controls.Add(this.button_disconnect);
            this.groupBox1.Controls.Add(button_connect);
            this.groupBox1.Controls.Add(this.label_ComPort);
            this.groupBox1.Controls.Add(this.comboBox_Port);
            this.groupBox1.Location = new System.Drawing.Point(9, 31);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(267, 170);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "communication setup";
            // 
            // textBox_Status
            // 
            this.textBox_Status.BackColor = System.Drawing.Color.Red;
            this.textBox_Status.Font = new System.Drawing.Font("Myanmar Text", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox_Status.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.textBox_Status.Location = new System.Drawing.Point(46, 72);
            this.textBox_Status.Name = "textBox_Status";
            this.textBox_Status.Size = new System.Drawing.Size(192, 28);
            this.textBox_Status.TabIndex = 6;
            this.textBox_Status.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // button_disconnect
            // 
            this.button_disconnect.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button_disconnect.Location = new System.Drawing.Point(152, 121);
            this.button_disconnect.Name = "button_disconnect";
            this.button_disconnect.Size = new System.Drawing.Size(109, 36);
            this.button_disconnect.TabIndex = 5;
            this.button_disconnect.Text = "Disconnect";
            this.button_disconnect.UseVisualStyleBackColor = true;
            this.button_disconnect.Click += new System.EventHandler(this.button_disconnect_Click);
            // 
            // button_connect
            // 
            button_connect.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            button_connect.ForeColor = System.Drawing.Color.Black;
            button_connect.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            button_connect.Location = new System.Drawing.Point(6, 121);
            button_connect.Name = "button_connect";
            button_connect.Size = new System.Drawing.Size(116, 36);
            button_connect.TabIndex = 4;
            button_connect.Text = "Connect";
            button_connect.UseVisualStyleBackColor = true;
            button_connect.Click += new System.EventHandler(this.button_connect_Click);
            // 
            // label_ComPort
            // 
            this.label_ComPort.AutoSize = true;
            this.label_ComPort.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.label_ComPort.ForeColor = System.Drawing.Color.DarkBlue;
            this.label_ComPort.Location = new System.Drawing.Point(6, 25);
            this.label_ComPort.Name = "label_ComPort";
            this.label_ComPort.Size = new System.Drawing.Size(90, 18);
            this.label_ComPort.TabIndex = 2;
            this.label_ComPort.Text = "COM PORT";
            // 
            // comboBox_Port
            // 
            this.comboBox_Port.AutoCompleteCustomSource.AddRange(new string[] {
            "1200",
            "2400",
            "4800",
            "9600",
            "19200",
            "38400"});
            this.comboBox_Port.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_Port.ForeColor = System.Drawing.SystemColors.ActiveBorder;
            this.comboBox_Port.FormattingEnabled = true;
            this.comboBox_Port.Location = new System.Drawing.Point(102, 27);
            this.comboBox_Port.Name = "comboBox_Port";
            this.comboBox_Port.Size = new System.Drawing.Size(157, 21);
            this.comboBox_Port.TabIndex = 0;
            this.comboBox_Port.SelectedIndexChanged += new System.EventHandler(this.comboBox_Port_SelectedIndexChanged);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label_counter);
            this.groupBox2.Controls.Add(this.textBox_SW);
            this.groupBox2.Location = new System.Drawing.Point(282, 31);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(194, 71);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "switch control";
            // 
            // label_counter
            // 
            this.label_counter.AutoSize = true;
            this.label_counter.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_counter.Location = new System.Drawing.Point(0, 35);
            this.label_counter.Name = "label_counter";
            this.label_counter.Size = new System.Drawing.Size(86, 13);
            this.label_counter.TabIndex = 8;
            this.label_counter.Text = "COUTER(SW)";
            // 
            // textBox_SW
            // 
            this.textBox_SW.BackColor = System.Drawing.SystemColors.HotTrack;
            this.textBox_SW.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox_SW.Location = new System.Drawing.Point(92, 32);
            this.textBox_SW.Name = "textBox_SW";
            this.textBox_SW.Size = new System.Drawing.Size(94, 20);
            this.textBox_SW.TabIndex = 7;
            this.textBox_SW.Text = "0";
            this.textBox_SW.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_SW.TextChanged += new System.EventHandler(this.textBox_SW_TextChanged);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.pictureBox1);
            this.groupBox3.Controls.Add(this.button_OffRE1);
            this.groupBox3.Controls.Add(this.button_ONRE1);
            this.groupBox3.Location = new System.Drawing.Point(285, 108);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(191, 114);
            this.groupBox3.TabIndex = 5;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Controll Led RE1";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::GiaoDienBluetooth.Properties.Resources.th__1_;
            this.pictureBox1.InitialImage = null;
            this.pictureBox1.Location = new System.Drawing.Point(15, 28);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(70, 70);
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            this.pictureBox1.Click += new System.EventHandler(this.pictureBox1_Click);
            // 
            // button_OffRE1
            // 
            this.button_OffRE1.Location = new System.Drawing.Point(100, 61);
            this.button_OffRE1.Name = "button_OffRE1";
            this.button_OffRE1.Size = new System.Drawing.Size(83, 28);
            this.button_OffRE1.TabIndex = 1;
            this.button_OffRE1.Text = "OFF";
            this.button_OffRE1.UseVisualStyleBackColor = true;
            this.button_OffRE1.Click += new System.EventHandler(this.button_OffRE1_Click);
            // 
            // button_ONRE1
            // 
            this.button_ONRE1.Location = new System.Drawing.Point(100, 28);
            this.button_ONRE1.Name = "button_ONRE1";
            this.button_ONRE1.Size = new System.Drawing.Size(83, 28);
            this.button_ONRE1.TabIndex = 0;
            this.button_ONRE1.Text = "ON";
            this.button_ONRE1.UseVisualStyleBackColor = true;
            this.button_ONRE1.Click += new System.EventHandler(this.button_ONRE1_Click);
            // 
            // serial_port
            // 
            this.serial_port.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serial_port_DataReceived);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(495, 234);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBox_Status;
        private System.Windows.Forms.Button button_disconnect;
        private System.Windows.Forms.Label label_ComPort;
        private System.Windows.Forms.ComboBox comboBox_Port;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label_counter;
        private System.Windows.Forms.TextBox textBox_SW;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button button_OffRE1;
        private System.Windows.Forms.Button button_ONRE1;
        private System.IO.Ports.SerialPort serial_port;
    }
}

